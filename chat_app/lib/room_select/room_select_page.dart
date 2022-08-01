import 'package:chat_app/base_app_bar.dart';
import 'package:chat_app/edit_profile/edit_profile_page.dart';
import 'package:chat_app/entity/chat_room.dart';
import 'package:chat_app/add_chat_room/add_chat_room.dart';
import 'package:chat_app/repository/user_repository.dart';
import 'package:chat_app/room_select/partoner_list_tile.dart';
import 'package:chat_app/room_select/current_list_tile.dart';
import 'package:chat_app/room_select/room_select_controller.dart';
import 'package:chat_app/service/auth_service.dart';
import 'package:chat_app/setting_page/setting_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
        title: const Text("Room Select Page"),
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
                    return AlertDialog(
                      backgroundColor: Colors.green[100],
                      content: Stack(
                        alignment: Alignment.center,
                        children: [
                          CircleAvatar(
                            radius: 75.0,
                            backgroundColor: Colors.amber[100],
                            foregroundImage: NetworkImage(user.imageURL),
                            child: const CircularProgressIndicator(
                              backgroundColor: Color.fromARGB(255, 3, 104, 7),
                            ),
                          ),
                        ],
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)),
                      title: Align(
                        alignment: Alignment.center,
                        child: Text(
                          user.userName,
                        ),
                      ),
                      actions: <Widget>[
                        MaterialButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100),
                          ),
                          color: const Color.fromARGB(255, 240, 124, 116),
                          child: const Text("Edit"),
                          onPressed: () async {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EditProfilePage(
                                        imageURL: user.imageURL,
                                        userName: user.userName,
                                      )),
                            );
                          },
                        ),
                        MaterialButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100),
                          ),
                          color: const Color.fromARGB(255, 137, 196, 244),
                          child: const Text("Back"),
                          onPressed: () async {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
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
                    child:
                        chat.userIds[0] == ref.watch(authServiceProvider).userId
                            ? CurrentListTile(
                                chat: chat,
                                userIds: const [],
                                partnerUserId: "",
                              )
                            : PartonerListTile(
                                chat: chat,
                                userIds: const [],
                                partnerUserId: "",
                              )));
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const AddChatRoomPage(
                        chatId: "",
                        userName: "",
                        lastMessage: '',
                      )));
        },
        child: const Icon(Icons.search),
      ),
    );
  }
}
