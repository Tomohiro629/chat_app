import 'package:chat_app/repository/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final myProfileControllerProvider =
    ChangeNotifierProvider<EditProfileController>((ref) {
  return EditProfileController(ref.read);
});

class EditProfileController extends ChangeNotifier {
  bool loading = false;
  final Reader _reader;
  EditProfileController(this._reader);

  Future<void> updataUserName(
      {required String editUserName, required String userId}) async {
    await _reader(userRepositoryProvider)
        .updateUserName(editUserName: editUserName, userId: userId);
  }
}
