import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authServiceProvider = ChangeNotifierProvider<AuthService>((ref) {
  return AuthService();
});

class AuthService extends ChangeNotifier {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<String> createUserWithEmailAndPassword(
      String email, String password, String authName) async {
    final authResult = await firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return authResult.user!.uid;
  }

  Future getCurrentUser() async {
    return firebaseAuth.currentUser;
  }
}
