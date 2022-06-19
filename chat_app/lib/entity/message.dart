class Message {
  Message({
    required this.message,
    required this.messageId,
    required this.sendTime,
    required this.chatId,
  });

  factory Message.fromJson(Map<String, dynamic> map) {
    return Message(
      message: map['message'],
      messageId: map['messageId'],
      sendTime: map['sendTime'],
      chatId: map['chatId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'messageId': messageId,
      'sendTime': sendTime,
      'chatId': chatId,
    };
  }

  final String message;
  final String messageId;
  final String sendTime;
  final String chatId;
}
