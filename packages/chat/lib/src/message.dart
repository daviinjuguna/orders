class Message {
  final int chartResponseId;
  final String sender;
  final String message;
  Message({
    required this.chartResponseId,
    required this.sender,
    required this.message,
  });

  int get nextId {
    if (chartResponseId == 1) {
      if (message.contains('yes')) {
        return 2;
      } else {
        return 3;
      }
    }
    if (chartResponseId == 2) {
      if (message.contains("good")) {
        return 5;
      } else {
        return 4;
      }
    }
    if (chartResponseId == 3) {
      if (message.contains("place")) {
        return 6;
      } else if (message.contains("track")) {
        return 2;
      } else {
        return 4;
      }
    }
    if (chartResponseId == 6) {
      if (message.contains("good")) {
        return 5;
      } else if (message.contains("else")) {
        return 3;
      } else {
        return 4;
      }
    }
    return 0;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Message &&
        other.chartResponseId == chartResponseId &&
        other.sender == sender &&
        other.message == message;
  }

  @override
  int get hashCode =>
      chartResponseId.hashCode ^ sender.hashCode ^ message.hashCode;
}
