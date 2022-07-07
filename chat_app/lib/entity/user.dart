class User {
  User({
    required this.userName,
    required this.userId,
  });

  factory User.create({
    required String userId,
    required String userNameText,
  }) {
    return User(
      userId: userId,
      userName: userNameText,
    );
  }

  factory User.fromJson(Map<String, dynamic> map) {
    return User(
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
