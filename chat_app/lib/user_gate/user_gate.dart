import 'package:chat_app/entity/users.dart';
import 'package:chat_app/room_select/room_select_page.dart';
import 'package:chat_app/service/auth_service.dart';
import 'package:chat_app/service/user_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserGatePage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userId = ref.watch(authServiceProvider).userId;
    final currentUser = ref.watch(userServiceProvider).fetchUserStream(userId);
    return StreamBuilder<Users?>(
      stream: currentUser,
      builder: ((context, snapshot) {
        final isExist = snapshot.data != null;
        return isExist ? const RoomSelectPage(chatName: "") : SetProfilPage();
      }),
    );
  }
}
