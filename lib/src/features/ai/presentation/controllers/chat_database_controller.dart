import 'dart:developer';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../application/providers/chat_message_repository_provider.dart';
import '../../application/providers/chat_repository_provider.dart';
import '../../domain/entities/chat.dart';
import '../../domain/entities/chat_message.dart';
import '../../domain/enums/ai_message_role_enum.dart';
import '../../domain/enums/chat_status_enum.dart';
import '../../domain/enums/message_status_enum.dart';
import 'chat_controller.dart';

part 'chat_database_controller.g.dart';

@riverpod
class ChatDatabaseController extends _$ChatDatabaseController {
  bool _isChatCreated = false;

  @override
  void build(String chatUid) {
    ref.listen(chatControllerProvider(chatUid), (previous, next) {
      if (next.isNotEmpty) {
        if (next.last.id == null) _syncProcess(next.last);
      }
    });
  }

  Future<void> _syncProcess(ChatMessage lastMessage) async {
    final chatRepository = ref.read(chatRepositoryProvider);
    final chatMessageRepository = ref.read(chatMessageRepositoryProvider);

    try {
      if (!_isChatCreated) {
        final chatExists = await chatRepository.exists(chatUid);

        if (!chatExists && lastMessage.role == MessageRoleEnum.user) {
          final chat = Chat(
            uid: chatUid,
            title: lastMessage.content,
            status: ChatStatusEnum.started,
            lastMessage: '',
            lastMessageDateTime: lastMessage.dateTime,
            dateTime: DateTime.now(),
          );

          await chatRepository.insert(chat);

          _isChatCreated = true;

          log('::: Chat created: $chatUid');
        }
      }

      if ((lastMessage.role != MessageRoleEnum.system) &&
          ((lastMessage.status == MessageStatusEnum.completed) ||
              lastMessage.status == MessageStatusEnum.failed)) {
        var newStatus = (lastMessage.status == MessageStatusEnum.failed)
            ? MessageStatusEnum.savedWithFailure
            : MessageStatusEnum.saved;

        await chatMessageRepository.saveMessage(
          lastMessage.copyWith(status: newStatus),
        );
      }

      if (lastMessage.status == MessageStatusEnum.completed) {
        await chatRepository.update(
          chatUid,
          lastMessage: lastMessage.content,
          lastMessageDateTime: lastMessage.dateTime,
        );
      }

      log('::: Database Sync: message ${lastMessage.uid} updated.');
    } catch (e) {
      log('::: Database sync error: $e');
    }
  }
}
