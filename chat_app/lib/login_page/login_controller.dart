import 'package:chat_app/service/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final loginControllerProvider = ChangeNotifierProvider<LoginController>((ref) {
  return LoginController(ref.read);
});

class LoginController extends ChangeNotifier {
  final Reader _reader;
  LoginController(this._reader);
  String errorMessage = '';

  void setErrorMessage(String errorText) {
    errorMessage = errorText;
    notifyListeners();
  }

  Future<void> loginUser({
    required String email,
    required String password,
  }) async {
    await _reader(authServiceProvider)
        .loginUser(email: email, password: password);
  }
}
