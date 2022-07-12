class ChatUser {
  ChatUser({
    required this.userName,
    required this.userId,
  });

  factory ChatUser.create({
    required String userId,
    required String userNameText,
  }) {
    return ChatUser(
      userId: userId,
      userName: userNameText,
    );
  }

  factory ChatUser.fromJson(Map<String, dynamic> map) {
    return ChatUser(
      userId: map['userId'],
      userName: map['userName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'userName': userName,
    };
  }

  final String userId;
  final String userName;
}
