class ChatUser {
  ChatUser({
    required this.userName,
    required this.userId,
    required this.imageURL,
  });

  factory ChatUser.create({
    required String userId,
    required String userNameText,
    required String? imageURL,
  }) {
    return ChatUser(
      userId: userId,
      userName: userNameText,
      imageURL: imageURL.toString(),
    );
  }

  factory ChatUser.fromJson(Map<String, dynamic> map) {
    return ChatUser(
      userId: map['userId'],
      userName: map['userName'],
      imageURL: map['imageURL'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'userName': userName,
      'imageURL': imageURL,
    };
  }

  final String userId;
  final String userName;
  final String imageURL;
}
