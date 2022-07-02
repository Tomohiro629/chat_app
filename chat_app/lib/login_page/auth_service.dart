import 'package:chat_app/entity/user.dart';
import 'package:chat_app/repository/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authServiceProvider = ChangeNotifierProvider<AuthService>((ref) {
  return AuthService(ref.read);
});

class AuthService extends ChangeNotifier {
  final auth = FirebaseAuth.instance;
  final Reader _reader;
  AuthService(this._reader);

  Future<String> createUserWithEmailAndPassword(
    String email,
    String password,
  ) async {
    final authResult = await auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return authResult.user!.uid;
  }

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

  Future<void> deleteUser() async {
    await _reader(userRepositoryProvider).deleteUser();
  }

  Future<void> logOut() async {
    await auth.signOut();
    notifyListeners();
  }
}
