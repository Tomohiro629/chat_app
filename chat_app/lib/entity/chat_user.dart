class ChatUser {
  ChatUser({
    required this.userName,
    required this.userId,
    required this.imgURL,
  });

  factory ChatUser.create({
    required String userId,
    required String userNameText,
    required String imgURL,
  }) {
    return ChatUser(
      userId: userId,
      userName: userNameText,
      imgURL: imgURL,
    );
  }

  factory ChatUser.fromJson(Map<String, dynamic> map) {
    return ChatUser(
      userId: map['userId'],
      userName: map['userName'],
      imgURL: map['imgURL'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'userName': userName,
      'imgURL': imgURL,
    };
  }

  final String userId;
  final String userName;
  final String imgURL;
}
