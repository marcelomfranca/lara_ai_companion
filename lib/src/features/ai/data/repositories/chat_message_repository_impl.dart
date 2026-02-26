// lib/features/auth/domain/repositories/auth_repository.dart
import 'dart:convert';

import 'package:lara_ai/src/core/domain/exceptions/app_exception.dart';
import 'package:lara_ai/src/features/ai/domain/data/data_sources/get_messages_data_source.dart';
import 'package:lara_ai/src/features/ai/domain/data/data_sources/save_message_data_source.dart';
import 'package:lara_ai/src/features/ai/domain/data/repositories/chat_message_repository.dart';
import 'package:lara_ai/src/features/ai/domain/entities/chat_message.dart';
import 'package:lara_ai/src/features/ai/domain/enums/ai_message_role_enum.dart';
import 'package:lara_ai/src/features/ai/domain/enums/message_status_enum.dart';
import 'package:lara_ai/src/features/ai/domain/exceptions/unable_get_chat_messages_exception.dart';

final class ChatMessageRepositoryImpl implements ChatMessageRepository {
  ChatMessageRepositoryImpl({
    required GetMessagesDataSource getMessagesDataSource,
    required SaveMessageDataSource saveMessageDataSource,
  }) : _getMessagesDataSource = getMessagesDataSource,
       _saveMessageDataSource = saveMessageDataSource;

  final GetMessagesDataSource _getMessagesDataSource;
  final SaveMessageDataSource _saveMessageDataSource;

  @override
  Future<List<ChatMessage>> getMessages(
    String uid, {
    int? start,
    int? limit,
  }) async {
    try {
      final maps = await _getMessagesDataSource.getAll(
        uid,
        start: start,
        limit: limit,
      );

      return List.generate(maps.length, (i) {
        final dateTime = DateTime.fromMillisecondsSinceEpoch(
          maps[i]['timestamp'],
        );
        final prompt = (maps[i]['prompt'] != null)
            ? jsonDecode(maps[i]['prompt'])
            : '';
        final content = jsonDecode(maps[i]['content']);

        return ChatMessage(
          id: maps[i]['id'],
          uid: maps[i]['uid'],
          chatUid: maps[i]['chat_uid'],
          role: MessageRoleEnum.values[maps[i]['role']],
          content: content,
          prompt: prompt,
          status: MessageStatusEnum.values[maps[i]['status']],
          dateTime: dateTime,
        );
      });
    } catch (e) {
      throw UnableGetChatMessagesException();
    }
  }

  @override
  Future<int> saveMessage(ChatMessage message) async {
    try {
      final map = {
        "uid": message.uid,
        "chat_uid": message.chatUid,
        "role": message.role.index,
        "content": jsonEncode(message.content),
        "status": message.status.index,
        "timestamp": message.dateTime.millisecondsSinceEpoch,
      };

      return await _saveMessageDataSource.save(map);
    } catch (e) {
      throw AppException(e.toString());
    }
  }
}
