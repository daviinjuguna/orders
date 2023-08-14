import 'package:chat/src/src.dart';
import 'package:flutter/foundation.dart';

class ChatResponse {
  final int id;
  final String sender;
  final String message;
  final List<String> selectOptions;

  factory ChatResponse.fromMessage(Message message) {
    return ChatResponse(
      id: message.chartResponseId,
      sender: message.sender,
      message: message.message,
      selectOptions: [],
    );
  }

  ChatResponse({
    required this.id,
    required this.sender,
    required this.message,
    required this.selectOptions,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ChatResponse &&
        other.id == id &&
        other.sender == sender &&
        other.message == message &&
        listEquals(other.selectOptions, selectOptions);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        sender.hashCode ^
        message.hashCode ^
        selectOptions.hashCode;
  }
}
