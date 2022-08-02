import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService();
});

class AuthService {
  final _auth = FirebaseAuth.instance;
  String get userId => _auth.currentUser!.uid; //カレントユーザーのIDをuserIdへ
  Stream<User?> get getAuthState => _auth.authStateChanges();

  Future<void> signUpUser(
      {required String newEmail, required String newPassword}) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: newEmail, password: newPassword);
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }

  Future<void> loginUser(
      {required String email, required String password}) async {
    await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> logOut() async {
    await _auth.signOut();
    if (_auth.currentUser == null) {
      print('ログアウト成功');
    }
  }
}
