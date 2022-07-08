import 'package:chat_app/service/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final signUpControllerProvider =
    ChangeNotifierProvider<SignUpController>((ref) {
  return SignUpController(ref.read);
});

class SignUpController extends ChangeNotifier {
  final Reader _reader;
  SignUpController(this._reader);

  Future<void> signUpUser({
    required String newEmail,
    required String newPassword,
  }) async {
    await _reader(authServiceProvider).signUpUser(
      newEmail: newEmail,
      newPassword: newPassword,
    );
  }
}
