import 'package:chat_app/entity/users.dart';
import 'package:chat_app/repository/user_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userServiceProvider = ChangeNotifierProvider<UserService>((ref) {
  return UserService(ref.read);
});

class UserService extends ChangeNotifier {
  final Reader _reader;
  UserService(this._reader);

  Future<void> addUser({
    required String userNameText,
    required String userId,
  }) async {
    final user = Users.create(userNameText: userNameText, userId: userId);
    await _reader(userRepositoryProvider).setUser(user: user);
  }

  Stream<List<Users>> fetchUsersStream(String userId) {
    return _reader(userRepositoryProvider).fetchUserStream();
  }

  Future<void> deleteUser() async {
    await _reader(userRepositoryProvider).deleteUser();
  }
}