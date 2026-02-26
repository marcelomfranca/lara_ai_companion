import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../../core/application/extensions/theme_build_context_extension.dart';
import '../../../../../../core/presentation/widgets/spinkit_three_bounce.dart';
import '../../../../domain/entities/chat_message.dart';
import '../../../../domain/enums/ai_message_role_enum.dart';
import '../../../../domain/enums/message_status_enum.dart';
import '../../../controllers/chat_controller.dart';
import 'fluid_text.dart';

class ChatBubbleWidget extends ConsumerWidget {
  const ChatBubbleWidget({
    super.key,
    required this.message,
    this.scrollController,
    this.onComplete,
    required this.chatUid,
  });

  final ChatMessage message;
  final ScrollController? scrollController;
  final void Function(bool)? onComplete;
  final String chatUid;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isUser = message.role == MessageRoleEnum.user;

    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.all(14),
        constraints: const BoxConstraints(maxWidth: 320),
        decoration: BoxDecoration(
          color: isUser ? const Color(0xFF007AFF) : Colors.grey.shade200,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(18),
            topRight: const Radius.circular(18),
            bottomLeft: isUser ? const Radius.circular(18) : Radius.zero,
            bottomRight: isUser ? Radius.zero : const Radius.circular(18),
          ),
        ),
        child: Builder(
          builder: (context) {
            if (message.role == MessageRoleEnum.assistant &&
                message.status != MessageStatusEnum.saved &&
                message.status != MessageStatusEnum.savedWithFailure) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  FluidText(
                    key: ValueKey(message.uid),
                    text: message.content,
                    isStreaming:
                        (message.status == MessageStatusEnum.streaming),
                    scrollController: scrollController,
                    onComplete: onComplete,
                    onRetry:
                        ((message.status == MessageStatusEnum.failed) &&
                            (message.prompt != null))
                        ? () {
                            final messageContent = message.prompt ?? '';

                            ref
                                .read(chatControllerProvider(chatUid).notifier)
                                .sendMessage(messageContent, false);
                          }
                        : null,
                  ),

                  if (message.status == MessageStatusEnum.streaming) ...[
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: SpinKitThreeBounce(
                          color: context.colors.titaniumEcho,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ],
              );
            }

            WidgetsBinding.instance.addPostFrameCallback(
              (_) => onComplete?.call(true),
            );

            final role = (message.role == MessageRoleEnum.user)
                ? TextStyle(color: context.colors.white)
                : null;

            if (message.role == MessageRoleEnum.assistant &&
                message.status == MessageStatusEnum.savedWithFailure) {
              return Column(
                children: <Widget>[
                  MarkdownBody(
                    key: ValueKey(message.uid),
                    data: message.content,
                    selectable: true,
                    shrinkWrap: true,
                    styleSheet: MarkdownStyleSheet(p: role),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      icon: Icon(
                        Icons.refresh,
                        color: context.colors.electricCyan,
                      ),
                      onPressed: (message.prompt != null)
                          ? () {
                              final messageContent = message.prompt ?? '';

                              ref
                                  .read(
                                    chatControllerProvider(chatUid).notifier,
                                  )
                                  .sendMessage(messageContent, false);
                            }
                          : null,
                    ),
                  ),
                ],
              );
            }

            return MarkdownBody(
              key: ValueKey(message.uid),
              data: message.content,
              selectable: true,
              shrinkWrap: true,
              styleSheet: MarkdownStyleSheet(p: role),
            );
          },
        ),
      ),
    );
  }
}
