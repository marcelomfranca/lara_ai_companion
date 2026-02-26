import '../enums/ai_message_role_enum.dart';
import '../enums/message_status_enum.dart';

class ChatMessage {
  const ChatMessage({
    this.id,
    required this.uid,
    required this.chatUid,
    required this.role,
    required this.content,
    required this.status,
    this.prompt,
    required this.dateTime,
  });

  final int? id;
  final String uid;
  final String chatUid;
  final MessageRoleEnum role;
  final String content;
  final MessageStatusEnum status;
  final String? prompt;
  final DateTime dateTime;

  ChatMessage copyWith({String? content, MessageStatusEnum? status}) {
    return ChatMessage(
      id: id,
      uid: uid,
      chatUid: chatUid,
      role: role,
      content: content ?? this.content,
      status: status ?? this.status,
      prompt: prompt,
      dateTime: dateTime,
    );
  }
}
