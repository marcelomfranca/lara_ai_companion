// lib/features/auth/domain/repositories/auth_repository.dart
import 'dart:convert';

import 'package:lara_ai/src/core/domain/exceptions/app_exception.dart';
import 'package:lara_ai/src/features/ai/domain/data/data_sources/delete_chat_data_source.dart';
import 'package:lara_ai/src/features/ai/domain/data/data_sources/exists_chat_data_source.dart';
import 'package:lara_ai/src/features/ai/domain/data/data_sources/get_chats_data_source.dart';
import 'package:lara_ai/src/features/ai/domain/data/data_sources/insert_chat_data_source.dart';
import 'package:lara_ai/src/features/ai/domain/data/data_sources/update_chat_data_source.dart';
import 'package:lara_ai/src/features/ai/domain/data/repositories/chat_repository.dart';
import 'package:lara_ai/src/features/ai/domain/entities/chat.dart';
import 'package:lara_ai/src/features/ai/domain/enums/chat_status_enum.dart';

final class ChatRepositoryImpl implements ChatRepository {
  ChatRepositoryImpl({
    required GetChatsDataSource getChatsDataSource,
    required InsertChatDataSource insertChatDataSource,
    required UpdateChatDataSource updateChatDataSource,
    required ExistsChatDataSource existsChatDataSource,
    required DeleteChatDataSource deleteChatDataSource,
  }) : _getChatsDataSource = getChatsDataSource,
       _insertChatDataSource = insertChatDataSource,
       _updateChatDataSource = updateChatDataSource,
       _existsChatDataSource = existsChatDataSource,
       _deleteChatDataSource = deleteChatDataSource;

  final GetChatsDataSource _getChatsDataSource;
  final InsertChatDataSource _insertChatDataSource;
  final UpdateChatDataSource _updateChatDataSource;
  final ExistsChatDataSource _existsChatDataSource;
  final DeleteChatDataSource _deleteChatDataSource;

  @override
  Future<List<Chat>> getAll({int? start, int? limit}) async {
    try {
      final maps = await _getChatsDataSource.getChats();

      final list = List.generate(maps.length, (i) {
        final dateTime = DateTime.fromMillisecondsSinceEpoch(
          maps[i]['timestamp'],
        );
        final lastMessageDateTime = DateTime.fromMillisecondsSinceEpoch(
          maps[i]['last_message_timestamp'],
        );
        final lastMessage = jsonDecode(maps[i]['last_message']);
        final title = jsonDecode(maps[i]['title']);
        final status = ChatStatusEnum.values[maps[i]['status']];

        return Chat(
          id: maps[i]['id'],
          uid: maps[i]['uid'],
          title: title,
          status: status,
          lastMessage: lastMessage,
          lastMessageDateTime: lastMessageDateTime,
          dateTime: dateTime,
        );
      });

      return list;
    } catch (e) {
      throw AppException(e.toString());
    }
  }

  @override
  Future<bool> exists(String uid) async {
    try {
      return await _existsChatDataSource.exists(uid);
    } catch (e) {
      throw AppException(e.toString());
    }
  }

  @override
  Future<int> insert(Chat chat) async {
    try {
      final map = {
        "uid": chat.uid,
        "title": jsonEncode(chat.title),
        "status": chat.status.index,
        "last_message": jsonEncode(chat.lastMessage),
        "last_message_timestamp":
            chat.lastMessageDateTime.millisecondsSinceEpoch,
        "timestamp": chat.dateTime.millisecondsSinceEpoch,
      };

      return await _insertChatDataSource.insert(map);
    } catch (e) {
      throw AppException(e.toString());
    }
  }

  @override
  Future<int> update(
    String uid, {
    ChatStatusEnum? status,
    String? lastMessage,
    DateTime? lastMessageDateTime,
  }) async {
    try {
      final map = {
        if (status != null) "status": status.index,
        if (lastMessage != null) "last_message": jsonEncode(lastMessage),
        if (lastMessageDateTime != null)
          "last_message_timestamp": lastMessageDateTime.millisecondsSinceEpoch,
      };

      return await _updateChatDataSource.update(uid, map: map);
    } catch (e) {
      throw AppException(e.toString());
    }
  }

  @override
  Future<void> delete(List<int> indexList, [bool? all = false]) async {
    try {
      return await _deleteChatDataSource.delete(indexList, all);
    } catch (e) {
      throw AppException(e.toString());
    }
  }
}
