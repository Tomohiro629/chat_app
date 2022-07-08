import 'package:chat_app/service/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final signInControllerProvider =
    ChangeNotifierProvider<SignInController>((ref) {
  return SignInController(ref.read);
});

class SignInController extends ChangeNotifier {
  final Reader _reader;
  SignInController(this._reader);

  Future<void> signInUser({
    required String newEmail,
    required String newPassword,
  }) async {
    await _reader(authServiceProvider).signInUser(
      newEmail: newEmail,
      newPassword: newPassword,
    );
  }
}
