import 'package:lara_ai/src/features/ai/presentation/controllers/chat_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../application/providers/chat_message_repository_provider.dart';

part 'load_chat_messages_controller.g.dart';

@riverpod
class LoadChatMessagesController extends _$LoadChatMessagesController {
  late final _chatMessagesRepository = ref.read(chatMessageRepositoryProvider);

  @override
  FutureOr<void> build() => null;

  Future<void> getMessages(String chatUid) async {
    state = AsyncValue.loading();

    try {
      final messages = await _chatMessagesRepository.getMessages(chatUid);

      await Future.delayed(const Duration(milliseconds: 600));

      ref.read(chatControllerProvider(chatUid).notifier).loadList(messages);

      state = AsyncValue.data(null);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }
}
