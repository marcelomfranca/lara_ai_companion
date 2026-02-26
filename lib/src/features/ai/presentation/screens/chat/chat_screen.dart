import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lara_ai/src/core/presentation/widgets/spinkit_three_bounce.dart';
import 'package:lara_ai/src/features/ai/presentation/controllers/chat_database_controller.dart';
import 'package:uuid/uuid.dart';

import '../../../../../core/application/extensions/async_value_extension.dart';
import '../../../../../core/application/extensions/hardcoded_string_extension.dart';
import '../../../../../core/application/extensions/theme_build_context_extension.dart';
import '../../../../../core/application/providers/internet_connection_provider.dart';
import '../../../../../core/presentation/widgets/lara_logo.dart';
import '../../../../../core/presentation/widgets/screen_config_widget.dart';
import '../../../../../core/presentation/widgets/spinkit_wave.dart';
import '../../../../../core/utils/functions/show_snack_bar_error_function.dart';
import '../../controllers/chat_controller.dart';
import '../../controllers/load_chat_messages_controller.dart';
import 'widgets/chat_bubble_widget.dart';

class ChatScreen extends ConsumerStatefulWidget {
  const ChatScreen({super.key, this.chatUid});

  final String? chatUid;

  @override
  ConsumerState<ChatScreen> createState() => _ChatScreenConsumerState();
}

class _ChatScreenConsumerState extends ConsumerState<ChatScreen> {
  final uuid = Uuid();
  late final _chatUid = widget.chatUid ?? uuid.v4();
  final _controller = TextEditingController();
  final _scrollController = ScrollController();
  var _isLoading = false;

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!ref.context.mounted) return;

      if (widget.chatUid != null) {
        ref
            .read(loadChatMessagesControllerProvider.notifier)
            .getMessages(widget.chatUid!);
      } else {
        ref
            .read(chatControllerProvider(_chatUid).notifier)
            .sendMessage('higrt', false);
      }

      ref.read(chatControllerProvider(_chatUid).notifier).errorStream.listen((
        errorMessage,
      ) {
        if (!mounted) return;

        showSnackBarOnError(errorMessage, context);
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  //verificar conexao sempre ao enviar mensagem
  //criar uma fila de mensagens offline e se der erro colocar a mensagem na fila para retry
  //configurar tema dark
  //corrigir bug de tela na settings e about

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue<void>>(
      loadChatMessagesControllerProvider,
      (_, state) => state.showSnackBarOnError(context),
    );

    final messages = ref.watch(chatControllerProvider(_chatUid));

    ref.listen(chatControllerProvider(_chatUid), (_, _) {
      _scrollToBottom();
    });

    final size = MediaQuery.of(context).size.width;

    ref.watch(chatDatabaseControllerProvider(_chatUid));

    final loadMessageState = ref.watch(loadChatMessagesControllerProvider);
    final isLoadingMessages = loadMessageState.isLoading;

    return ScreenConfigWidget(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: Scaffold(
          appBar: AppBar(
            flexibleSpace: Container(
              decoration: context.decorations.appBarGradient,
            ),
            iconTheme: IconThemeData(color: context.colors.white),
            // leadingWidth: 36,
            centerTitle: false,
            titleSpacing: 0.0,
            title: Consumer(
              builder: (context, ref, child) {
                final isConnected =
                    ref.watch(internetConnectionProvider).value ?? true;

                return Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: <Widget>[
                      LaraLogo(size: 42),
                      const SizedBox(width: 5),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'LARA'.hardcoded,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          Text(
                            isConnected
                                ? 'Online'.hardcoded
                                : 'Offline'.hardcoded,
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.8),
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
            actions: _isLoading
                ? <Widget>[
                    IconButton(
                      icon: const Icon(Icons.stop),
                      color: Colors.red,
                      onPressed: () {
                        ref
                            .read(chatControllerProvider(_chatUid).notifier)
                            .cancelGeneration();

                        setState(() {
                          _isLoading = false;
                        });
                      },
                    ),
                  ]
                : null,
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),

          body: Column(
            children: <Widget>[
              Expanded(
                child: Builder(
                  builder: (context) {
                    if (isLoadingMessages) {
                      return Center(
                        child: SpinKitThreeBounce(
                          color: context.colors.primary,
                          size: size * 0.05,
                        ),
                      );
                    }

                    return ListView.builder(
                      controller: _scrollController,
                      restorationId: 'chatMessageList'.hardcoded,
                      key: ValueKey('chatMessageListKey'),
                      padding: const EdgeInsets.all(16),
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
                        return ChatBubbleWidget(
                          key: ValueKey(messages[index].id),
                          chatUid: _chatUid,
                          message: messages[index],
                          scrollController: _scrollController,
                          onComplete: (completed) {
                            if (completed) {
                              _isLoading = false;

                              setState(() {});
                            }
                          },
                        );
                      },
                    );
                  },
                ),
              ),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _controller,
                          minLines: 1,
                          maxLines: null,
                          decoration: InputDecoration(
                            hintText: 'Talk to me...'.hardcoded,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                          ),
                        ),
                      ),
                      Builder(
                        builder: (context) {
                          if (_isLoading) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SpinKitWave(
                                color: context.colors.titaniumEcho,
                                size: 16,
                              ),
                            );
                          }

                          return IconButton(
                            icon: const Icon(Icons.send),
                            onPressed: () {
                              FocusManager.instance.primaryFocus?.unfocus();

                              final text = _controller.text.trim();

                              if (text.isEmpty) return;

                              ref
                                  .read(
                                    chatControllerProvider(_chatUid).notifier,
                                  )
                                  .sendMessage(text);

                              _controller.clear();

                              _isLoading = true;

                              setState(() {});
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
