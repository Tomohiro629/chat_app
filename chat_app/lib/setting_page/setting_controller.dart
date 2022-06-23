import 'package:chat_app/entity/user.dart';
import 'package:chat_app/repository/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final settingControllerProvider =
    ChangeNotifierProvider<SettingController>((ref) {
  return SettingController(ref.read);
});

class SettingController extends ChangeNotifier {
  final auth = FirebaseAuth.instance;
  final Reader _reader;
  SettingController(this._reader);

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

  Future<void> deleteUser({
    required Users user,
  }) async {
    await _reader(settingControllerProvider).deleteUser(user: user);
  }

  Future<void> logOut() async {
    await auth.signOut();
    notifyListeners();
  }
}
