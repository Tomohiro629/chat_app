class Message {
  Message({
    required this.message,
    required this.id,
    required this.sendTime,
  });

  factory Message.fromJson(Map<String, dynamic> map) {
    return Message(
      message: map['message'],
      id: map['id'],
      sendTime: map['sendTime'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'id': id,
      'sendTime': sendTime,
    };
  }

  final String message;
  final String id;
  final String sendTime;
}
