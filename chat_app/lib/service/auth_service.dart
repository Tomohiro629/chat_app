import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService();
});

class AuthService {
  final _auth = FirebaseAuth.instance;
  String get userId => _auth.currentUser!.uid;
  Stream<User?> get getAuthState => _auth.authStateChanges();
}