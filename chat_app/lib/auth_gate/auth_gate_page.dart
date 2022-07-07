import 'package:chat_app/home_page/home_page.dart';
import 'package:chat_app/room_select/room_select_page.dart';
import 'package:chat_app/service/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthGatePage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _authUser = ref.watch(authServiceProvider).getAuthState();
    return StreamBuilder<User?>(
      stream: _authUser,
      builder: ((context, snapshot) {
        final isLogin = snapshot.data != null;
        return isLogin ? const RoomSelectPage(chatName: "") : HomePage();
      }),
    );
  }
}
