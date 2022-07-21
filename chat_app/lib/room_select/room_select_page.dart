import 'package:chat_app/entity/chat_room.dart';
import 'package:chat_app/add_chat_room/add_chat_room.dart';
import 'package:chat_app/room_select/room_list_tile.dart';
import 'package:chat_app/room_select/room_select_controller.dart';
import 'package:chat_app/setting_page/setting_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterfire_ui/firestore.dart';

class RoomSelectPage extends ConsumerWidget {
  const RoomSelectPage(
      {Key? key, required this.userId, required this.currentUserId})
      : super(key: key);
  final String userId;
  final String currentUserId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(roomSelectControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Room Select Page"),
        centerTitle: true,
        actions: [
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
        query: controller.chatRoomQuery(),
        itemBuilder: (context, snapshot) {
          final chat = snapshot.data();
          return RoomListTile(
            chat: chat,
            userIds: [],
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
                        chatName: "",
                      )));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
