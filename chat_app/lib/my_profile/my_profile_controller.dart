import 'package:chat_app/repository/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final myProfileControllerProvider =
    ChangeNotifierProvider<MyProfileController>((ref) {
  return MyProfileController(ref.read);
});

class MyProfileController extends ChangeNotifier {
  bool loading = false;
  final Reader _reader;
  MyProfileController(this._reader);

  Future<void> getUser(String userId) async {
    await _reader(userRepositoryProvider).getUser(userId);
  }

  Future<void> updataUserName(
      {required String editUserName, required String userId}) async {
    await _reader(userRepositoryProvider)
        .updateUserName(editUserName: editUserName, userId: userId);
  }
}
