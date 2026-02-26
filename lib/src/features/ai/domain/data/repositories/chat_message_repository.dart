import 'package:lara_ai/src/features/ai/domain/entities/chat_message.dart';

abstract interface class ChatMessageRepository {
  Future<int> saveMessage(ChatMessage message);
  Future<List<ChatMessage>> getMessages(String uid, {int? start, int? limit});
}
