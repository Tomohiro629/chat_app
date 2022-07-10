import 'package:chat_app/home_page/home_page.dart';
import 'package:chat_app/service/auth_service.dart';
import 'package:chat_app/user_gate/user_gate_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthGatePage extends ConsumerWidget {
  const AuthGatePage({Key? key, required this.userId}) : super(key: key);
  final String userId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authUser = ref.watch(authServiceProvider).getAuthState;
    return StreamBuilder<User?>(
      stream: authUser,
      builder: ((context, snapshot) {
        final isLogin = snapshot.data != null;
        return isLogin ? const UserGatePage() : const HomePage();
        //login,signup成功：失敗
      }),
    );
  }
}
