import 'dart:async';
import 'dart:developer';
import 'dart:math' as math;

import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/application/providers/internet_connection_provider.dart';
import '../../application/providers/ai_providers.dart';
import '../../domain/entities/chat_message.dart';
import '../../domain/enums/ai_message_role_enum.dart';
import '../../domain/enums/message_status_enum.dart';
import '../../domain/exceptions/create_chat_exception.dart';

part 'chat_controller.g.dart';

@riverpod
class ChatController extends _$ChatController {
  late final _model = ref.read(geminiModelProvider);
  final _uuid = Uuid();

  final _errorController = StreamController<String>.broadcast();
  Stream<String> get errorStream => _errorController.stream;

  StreamSubscription? _subscription;

  @override
  List<ChatMessage> build(String chatUid) {
    ref.onDispose(() {
      _subscription?.cancel();
      _errorController.close();
    });

    return [];
  }

  bool isConnected() => ref.read(internetConnectionProvider).value ?? true;

  void loadList(List<ChatMessage> list) => state = list;

  Stream<GenerateContentResponse> mockGenerateContentStream(
    String prompt,
  ) async* {
    final rnd = math.Random().nextInt(100);

    final responses = [
      "Olá $rnd! ",
      "Eu sou a ",
      "Lara, ",
      "sua assistente ",
      "em modo de simulação. ",
      "Estou respondendo ",
      "sem gastar sua quota! ",
      "Como posso ajudar hoje?",
    ];

    for (int i = 0; i < responses.length; i++) {
      await Future.delayed(const Duration(milliseconds: 150));

      if (i == 3) {
        throw Exception('Simulated network failure during streaming');
      }

      yield GenerateContentResponse([
        Candidate(
          Content.model([TextPart(responses[i])]),
          null,
          null,
          null,
          null,
        ),
      ], null);
    }
  }

  Future<void> sendMessage(
    String promptText, [
    bool showUserMessage = true,
  ]) async {
    try {
      final promptUid = _uuid.v4();

      log('promptUid: $promptUid');

      final prompt = ChatMessage(
        uid: promptUid,
        chatUid: chatUid,
        role: MessageRoleEnum.user,
        content: promptText,
        dateTime: DateTime.now(),
        status: MessageStatusEnum.completed,
      );

      if (showUserMessage) {
        state = [...state, prompt];
      }

      final assistantMessageUid = _uuid.v4();

      log('assistantMessageUid: $assistantMessageUid');

      final assistant = ChatMessage(
        uid: assistantMessageUid,
        chatUid: chatUid,
        role: MessageRoleEnum.assistant,
        content: '',
        dateTime: DateTime.now(),
        status: MessageStatusEnum.sending,
        prompt: promptText,
      );

      state = [...state, assistant];

      final stream = _model.generateContentStream([Content.text(promptText)]);
      // final stream = mockGenerateContentStream(promptText);

      String accumulated = '';

      _subscription = stream.listen(
        (chunk) {
          final text = chunk.text ?? '';
          accumulated += text;

          state = [
            ...state.sublist(0, state.length - 1),
            assistant.copyWith(
              content: accumulated,
              status: MessageStatusEnum.streaming,
            ),
          ];
        },
        onDone: () {
          final assistantCompleted = assistant.copyWith(
            content: accumulated,
            status: MessageStatusEnum.completed,
          );

          state = [...state.sublist(0, state.length - 1), assistantCompleted];
        },
        cancelOnError: true,
        onError: (error) {
          final errorMessage = 'Ops! Something went wrong: $error';

          state = [
            ...state.sublist(0, state.length - 1),
            assistant.copyWith(
              content: errorMessage,
              status: MessageStatusEnum.failed,
            ),
          ];

          log('::: Gemini Error: $error');
        },
      );
    } on GenerativeAIException catch (e) {
      if (e.message.contains('quota')) {
        _errorController.add(
          'You exceeded your current quota. Try again in 1 minute',
        );
      }
    } catch (error) {
      _errorController.add(CreateChatException().toString());
    }
  }

  void cancelGeneration() async {
    await _subscription?.cancel();

    final last = state.last;

    if (last.role == MessageRoleEnum.assistant) {
      state = [
        ...state.sublist(0, state.length - 1),
        last.copyWith(status: MessageStatusEnum.canceled),
      ];
    }
  }

  Future<void> testConnection() async {
    final model = ref.read(geminiModelProvider);

    final response = await model.generateContent([
      Content.text('Hi, are you listen?'),
    ]);

    log('::: Gemini response: ${response.text}');
  }
}
