import 'package:chat_app/base_app_bar.dart';
import 'package:chat_app/entity/chat_room.dart';
import 'package:chat_app/add_chat_room/add_chat_room.dart';
import 'package:chat_app/my_profile/my_profile_page.dart';
import 'package:chat_app/room_select/room_list_tile.dart';
import 'package:chat_app/room_select/room_select_controller.dart';
import 'package:chat_app/setting_page/setting_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterfire_ui/firestore.dart';

class RoomSelectPage extends ConsumerWidget {
  const RoomSelectPage({Key? key, required this.chatName}) : super(key: key);
  final String chatName;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final roomSelectController = ref.watch(roomSelectControllerProvider);

    return Scaffold(
      appBar: BaseAppBar(
        title: const Text("Room Select Page"),
        widgets: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return const MyProfilePage();
              }));
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
      body: FirestoreListView<ChatRoom>(
        query: roomSelectController.chatRoomQuery(),
        itemBuilder: (context, snapshot) {
          final chat = snapshot.data();
          return RoomListTile(
            chat: chat,
            userIds: const [],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const AddChatRoomPage(
                        chatId: "",
                        userName: "",
                      )));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
