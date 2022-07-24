import 'package:chat_app/base_app_bar.dart';
import 'package:chat_app/entity/chat_room.dart';
import 'package:chat_app/add_chat_room/add_chat_room.dart';
import 'package:chat_app/entity/chat_user.dart';
import 'package:chat_app/room_select/room_list_tile.dart';
import 'package:chat_app/room_select/room_select_controller.dart';
import 'package:chat_app/service/auth_service.dart';
import 'package:chat_app/service/user_service.dart';
import 'package:chat_app/setting_page/setting_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterfire_ui/firestore.dart';

class RoomSelectPage extends ConsumerWidget {
  const RoomSelectPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(roomSelectControllerProvider);
    final userController = ref.watch(userServiceProvider);
    final userId = ref.watch(authServiceProvider).userId;

    return Scaffold(
      appBar: BaseAppBar(
        title: const Text("Room Select Page"),
        widgets: [
          StreamBuilder<List<ChatUser>>(
              stream: userController.fetchUsersStream(userId),
              builder: (BuildContext context,
                  AsyncSnapshot<List<ChatUser>> snapshot) {
                if (snapshot.hasData) {
                  return Row(
                    children: snapshot.data!.map((ChatUser user) {
                      return CircleAvatar(
                        foregroundImage: NetworkImage(user.imageURL),
                      );
                    }).toList(),
                  );
                }
                if (snapshot.hasError) {
                  return const Text("error");
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }),
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
                        chatName: "",
                      )));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
