import 'package:chat_app/entity/user.dart';
import 'package:chat_app/repository/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final registertionControllerProvider =
    ChangeNotifierProvider<RegistertionController>((ref) {
  return RegistertionController(ref.read);
});

class RegistertionController extends ChangeNotifier {
  final Reader _reader;
  RegistertionController(this._reader);

  Future<void> addUser({
    required String userNameText,
    required String userId,
  }) async {
    final user = User.create(userNameText: userNameText, userId: userId);
    await _reader(userRepositoryProvider).setUser(user: user);
  }

  Future<void> deleteUser({
    required User user,
  }) async {
    await _reader(registertionControllerProvider).deleteUser(user: user);
  }
}
