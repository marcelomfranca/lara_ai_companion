import 'package:lara_ai/src/features/ai/domain/enums/chat_status_enum.dart';

import '../../entities/chat.dart';

abstract interface class ChatRepository {
  Future<int> insert(Chat chat);
  Future<int> update(
    String uid, {
    ChatStatusEnum? status,
    String? lastMessage,
    DateTime? lastMessageDateTime,
  });
  Future<bool> exists(String uid);
  Future<List<Chat>> getAll({int? start, int? limit});
  Future<void> delete(List<int> indexList, [bool? all = false]);
}
