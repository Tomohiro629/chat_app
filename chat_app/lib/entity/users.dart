import 'package:uuid/uuid.dart';

class Users {
  Users({
    required this.userName,
    required this.userId,
  });

  factory Users.create({
    required String userId,
    required String userNameText,
  }) {
    return Users(
      userId: const Uuid().v4(),
      userName: userNameText,
    );
  }

  factory Users.fromJson(Map<String, dynamic> map) {
    return Users(
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
