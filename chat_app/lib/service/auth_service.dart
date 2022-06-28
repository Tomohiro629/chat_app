import 'package:chat_app/local_user_data_source.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authServiceProvider = ChangeNotifierProvider<AuthService>((ref) {
  return AuthService(
    localUserDataSource: ref.read(localUserDataSourceProvider),
  );
});

class AuthService extends ChangeNotifier {
  final LocalUserDataSource localUserDataSource;
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  AuthService({
    required this.localUserDataSource,
  }) {
// if(this.firebaseAuth.currentUser ! = null)
    {}
  }
}
