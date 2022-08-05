import 'package:chat_app/bottom_navigation_bar/bottom_navigation_bar.dart';
import 'package:chat_app/entity/chat_user.dart';
import 'package:chat_app/room_select/room_select_page.dart';
import 'package:chat_app/service/auth_service.dart';
import 'package:chat_app/service/user_service.dart';
import 'package:chat_app/set_profile/set_profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserGatePage extends ConsumerWidget {
  const UserGatePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userId = ref.watch(authServiceProvider).userId;
    final currentUser = ref.watch(userServiceProvider).fetchUserStream(userId);
    return StreamBuilder<ChatUser?>(
      stream: currentUser,
      builder: ((context, snapshot) {
        final isExist = snapshot.data != null;
        return isExist
            ? BottomNavigationBarPage() //ユーザーがいたら
            : const SetProfilePage(); //失敗
        //
      }),
    );
  }
}
