import 'package:flutter/foundation.dart';
import 'package:lara_ai/src/features/ai/domain/enums/chat_status_enum.dart';

@immutable
class Chat {
  const Chat({
    this.id,
    required this.uid,
    required this.title,
    required this.status,
    required this.lastMessage,
    required this.lastMessageDateTime,
    required this.dateTime,
  });

  final int? id;
  final String uid;
  final String title;
  final ChatStatusEnum status;
  final String lastMessage;
  final DateTime lastMessageDateTime;
  final DateTime dateTime;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Chat &&
        other.id == id &&
        other.uid == uid &&
        other.lastMessage == lastMessage &&
        other.lastMessageDateTime == lastMessageDateTime &&
        other.dateTime == dateTime;
  }

  @override
  int get hashCode =>
      id.hashCode ^
      uid.hashCode ^
      lastMessage.hashCode ^
      lastMessageDateTime.hashCode ^
      dateTime.hashCode;
}
