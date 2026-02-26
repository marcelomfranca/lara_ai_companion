// import 'dart:convert';

// import '../../domain/entities/chat_message.dart';
// import '../../domain/enums/ai_message_role_enum.dart';
// import '../../domain/enums/message_status_enum.dart';

// class ChatMessage {
//   ChatMessage({
//     this.id,
//     required this.uid,
//     required this.chatUid,
//     required this.role,
//     required this.content,
//     required this.timestamp,
//     required this.status,
//     this.prompt,
//   });

//   final int? id;
//   final String uid;
//   final String chatUid;
//   final int role;
//   final String content;
//   final String timestamp;
//   final MessageStatusEnum status;
//   final ChatMessage? prompt;

//   factory ChatMessage.fromMap({required Map<String, dynamic> map}) {
//     final message = ChatMessage(
//       id: map['id'],
//       uid: map['uid'],
//       chatUid: map['chat_uid'],
//       content: jsonDecode(map['content']),
//       role: map['role'],
//       timestamp: map['timestamp'],
//       status: MessageStatusEnum.values[map['status']],
//       prompt: (map['prompt'] != null) ? jsonDecode(map['prompt']) : null,
//     );

//     return message;
//   }

//   Map<String, Object?> toMap([bool update = false]) {
//     final map = <String, Object?>{};

//     if (!update) {
//       map['uid'] = uid;
//     }

//     map['chat_uid'] = chatUid;
//     map['content'] = jsonEncode(content);
//     map['role'] = role;
//     map['timestamp'] = timestamp;
//     map['status'] = status.index;
//     map['prompt_id'] = prompt?.id;
//     // map['promptText'] = jsonEncode(prompt?.content);

//     return map;
//   }

//   ChatMessage toEntity({int? id}) => ChatMessage(
//     id: id ?? this.id,
//     uid: uid,
//     chatUid: chatUid,
//     role: MessageRoleEnum.values[role],
//     content: content,
//     timestamp: timestamp,
//     status: status,
//     prompt: prompt,
//   );

//   ChatMessage copyWith({int? id}) => ChatMessage(
//     id: id ?? this.id,
//     uid: uid,
//     chatUid: chatUid,
//     role: role,
//     content: content,
//     timestamp: timestamp,
//     status: status,
//     prompt: prompt,
//   );
// }
