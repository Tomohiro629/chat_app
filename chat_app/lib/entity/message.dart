class Message {
  Message({
    required this.message,
    required this.messageId,
    required this.sendTime,
  });

  factory Message.fromJson(Map<String, dynamic> map) {
    return Message(
      message: map['message'],
      messageId: map['id'],
      sendTime: map['sendTime'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'messageId': messageId,
      'sendTime': sendTime,
    };
  }

  final String message;
  final String messageId;
  final String sendTime;
}
