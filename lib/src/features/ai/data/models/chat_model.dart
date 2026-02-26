// import 'dart:convert';

// import 'chat_message_model.dart';
// import '../../domain/entities/chat_message.dart';
// import '../../domain/enums/chat_status_enum.dart';

// class ChatModel {
//   const ChatModel({
//     this.id,
//     required this.uid,
//     required this.title,
//     required this.timestamp,
//     required this.status,
//     required this.lastMessage,
//   });

//   final int? id;
//   final String? uid;
//   final String? title;
//   final String? timestamp;
//   final ChatStatusEnum? status;
//   final ChatMessage? lastMessage;

//   factory ChatModel.fromMap({required Map<String, dynamic> map}) {
//     final message = ChatModel(
//       id: map['id'],
//       uid: map['uid'],
//       title: jsonDecode(map['title']),
//       status: map['status'],
//       timestamp: map['timestamp'],
//       lastMessage: ChatMessage.fromMap(
//         map: jsonDecode(map['lastMessage']),
//       ).toEntity(),
//     );

//     return message;
//   }

//   Map<String, Object?> toMap([bool update = false]) {
//     final map = <String, Object?>{};

//     // if (!update) {
//     //   map['uid'] = uid;
//     // }

//     // map['title'] = jsonEncode(title);
//     // map['status'] = status.index;
//     // map['timestamp'] = timestamp;
//     // map['last_message'] = jsonEncode(
//     //   ChatMessageModel(
//     //     id: lastMessage.id,
//     //     uid: lastMessage.uid,
//     //     chatUid: lastMessage.chatUid,
//     //     role: lastMessage.role.index,
//     //     content: lastMessage.content,
//     //     timestamp: timestamp,
//     //     status: lastMessage.status,
//     //   ).toMap(),
//     // );

//     return map;
//   }

//   // Chat toEntity({required int id, int? promptId}) => ChatMessage(
//   //   id: id,
//   //   uid: uid,
//   //   chatUid: chatUid,
//   //   role: MessageRoleEnum.values[role],
//   //   content: content,
//   //   timestamp: timestamp,
//   //   status: status,
//   //   promptId: promptId,
//   // );

//   ChatModel copyWith({int? id}) => ChatModel(
//     id: id ?? this.id,
//     uid: uid,
//     title: title,
//     timestamp: timestamp,
//     status: status,
//     lastMessage: lastMessage,
//   );
// }
