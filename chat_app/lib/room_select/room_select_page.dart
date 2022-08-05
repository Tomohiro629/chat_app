import 'package:chat_app/base_app_bar.dart';
import 'package:chat_app/entity/chat_room.dart';
import 'package:chat_app/add_chat_room/add_chat_room.dart';
import 'package:chat_app/group_select/group_select_page.dart';
import 'package:chat_app/repository/user_repository.dart';
import 'package:chat_app/room_select/components/chat_list_tile.dart';
import 'package:chat_app/room_select/components/current_user_data_dialog.dart';
import 'package:chat_app/room_select/room_select_controller.dart';

import 'package:chat_app/service/auth_service.dart';
import 'package:chat_app/service/common_method.dart';
import 'package:chat_app/setting_page/setting_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterfire_ui/firestore.dart';

class RoomSelectPage extends ConsumerWidget {
  const RoomSelectPage({
    Key? key,
    required this.chatName,
  }) : super(key: key);
  final String chatName;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final roomSelectController = ref.watch(roomSelectControllerProvider);
    final userController = ref.watch(userRepositoryProvider);

    return Scaffold(
      appBar: BaseAppBar(
        title: const Text("Room Select"),
        widgets: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () async {
              final user = await userController.getUserDate(
                  userId: ref.watch(authServiceProvider).userId);
              showDialog(
                  barrierDismissible: true,
                  context: context,
                  builder: (childContext) {
                    return CurrentUserDateDialog(
                      user: user,
                    );
                  });
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return const SettingPage();
              }));
            },
          ),
        ],
      ),
      body: Center(
        child: FirestoreListView<ChatRoom>(
          query: roomSelectController.chatRoomQuery(),
          itemBuilder: (context, snapshot) {
            final chat = snapshot.data();
            return Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(40.0)),
                child: Padding(
                    //cardの幅
                    padding: const EdgeInsets.all(5.0),
                    child: ChatListTile(
                      chat: chat,
                      partnerUserId: getPartnerUserId(
                          ref.watch(authServiceProvider).userId, chat.userIds),
                    )));
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddChatRoomPage()));
        },
        child: const Icon(Icons.search),
      ),
    );
  }
}
