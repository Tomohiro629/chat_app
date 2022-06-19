class Chat {
  Chat({
    required this.chatName,
    required this.addTime,
    required this.roomId,
  });

  factory Chat.fromJson(Map<String, dynamic> map) {
    return Chat(
        chatName: map['chatName'],
        addTime: map['addTime'],
        roomId: map['roomId']);
  }

  Map<String, dynamic> toJson() {
    return {
      'chatName': chatName,
      'addTime': addTime,
      'roomId': roomId,
    };
  }

  final String chatName;
  final String addTime;
  final String roomId;
}
