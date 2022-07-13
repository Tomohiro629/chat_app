import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService();
});

class AuthService {
  final _auth = FirebaseAuth.instance;
  String get userId => _auth.currentUser!.uid; //カレントユーザーのIDをuserIdへ
  Stream<User?> get getAuthState => _auth.authStateChanges();
  String infoText = "";

  Future<void> signUpUser(
      {required String newEmail, required String newPassword}) async {
    await _auth.createUserWithEmailAndPassword(
        email: newEmail, password: newPassword);
  }

  Future<void> loginUser(
      {required String email, required String password}) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseException catch (e) {
      print(e);
      infoText = "Please Enter";
    }
  }
}
