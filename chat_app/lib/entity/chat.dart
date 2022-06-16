class Chat {
  Chat({
    required this.chatName,
  });

  factory Chat.fromJson(Map<String, dynamic> map) {
    return Chat(
      chatName: map['chatName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'chatName': chatName,
    };
  }

  final String chatName;
}
