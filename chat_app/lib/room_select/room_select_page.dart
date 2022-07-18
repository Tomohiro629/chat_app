import 'package:chat_app/chat_page/build_chat.dart';
import 'package:chat_app/entity/chat_room.dart';
import 'package:chat_app/entity/chat_user.dart';
import 'package:chat_app/repository/user_repository.dart';
import 'package:chat_app/room_select/add_chat_room.dart';
import 'package:chat_app/room_select/room_select_controller.dart';
import 'package:chat_app/setting_page/setting_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RoomSelectPage extends ConsumerWidget {
  const RoomSelectPage(
      {Key? key, required this.userId, required this.currentUserId})
      : super(key: key);
  final String userId;
  final String currentUserId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(roomSelectControllerProvider);
    final user = ref.watch(userRepositoryProvider);

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
      body: SingleChildScrollView(
        child: Column(
          children: [
            StreamBuilder<List<ChatUser>>(
              stream: user.fetchUsersStream(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<ChatUser>> snapshot) {
                if (snapshot.hasError) {
                  return Text("Error:${snapshot.error}");
                }
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return const Center();
                  default:
                    return ListView(
                      shrinkWrap: true,
                      children: snapshot.data!.map((ChatUser user) {
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
                          child: ListTile(
                            title: Text("「${user.userName}」でログイン中"),
                            // trailing: Image.network(user.imageURL),
                          ),
                        );
                      }).toList(),
                    );
                }
              },
            ),
            StreamBuilder<List<ChatRoom>>(
              stream: controller.fetchChatRoomStream(
                userId,
              ),
              builder: (BuildContext context,
                  AsyncSnapshot<List<ChatRoom>> snapshot) {
                if (snapshot.hasError) {
                  return Text("Error:${snapshot.error}");
                }
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return const Center();
                  default:
                    return ListView(
                      physics: const ClampingScrollPhysics(),
                      shrinkWrap: true,
                      children: snapshot.data!.map((ChatRoom chat) {
                        return Padding(
                          //card同士の余白
                          padding: const EdgeInsets.all(10),
                          child: Container(
                            decoration: const BoxDecoration(
                              color: Color.fromARGB(255, 185, 235, 187),
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(40),
                                  topLeft: Radius.circular(40),
                                  bottomLeft: Radius.circular(40),
                                  bottomRight: Radius.circular(40)),
                              gradient: LinearGradient(
                                begin: FractionalOffset.topLeft,
                                end: FractionalOffset.bottomRight,
                                colors: [
                                  Color.fromARGB(255, 13, 160, 87),
                                  Color.fromARGB(222, 98, 203, 115),
                                ],
                                stops: [
                                  0.0,
                                  1.0,
                                ],
                              ),
                            ),
                            child: Padding(
                                //cardの幅
                                padding:
                                    const EdgeInsets.fromLTRB(30, 50, 0, 50),
                                child: Column(
                                  children: <Widget>[
                                    Center(
                                      child: ListTile(
                                        title: Text(
                                          "「 ${chat.chatName}」room",
                                          style: const TextStyle(
                                            fontSize: 20,
                                            color: Color.fromARGB(
                                                255, 255, 255, 255),
                                          ),
                                        ),
                                        subtitle: Text(
                                          " 作成日${chat.addTime}",
                                          style: const TextStyle(
                                            fontSize: 12,
                                            color: Color.fromARGB(
                                                255, 202, 224, 7),
                                          ),
                                        ),
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      BuildChat(
                                                          chat: chat,
                                                          userId: "",
                                                          uid: "")));
                                        },
                                        onLongPress: () {
                                          showDialog(
                                              barrierDismissible: false,
                                              context: context,
                                              builder: (childContext) {
                                                return AlertDialog(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50)),
                                                  title: Text(
                                                      "Delete Room\n『${chat.chatName}』"),
                                                  content: const Text(
                                                      "Do you want to Delete it?"),
                                                  actions: <Widget>[
                                                    MaterialButton(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(100),
                                                      ),
                                                      color:
                                                          const Color.fromARGB(
                                                              255,
                                                              240,
                                                              124,
                                                              116),
                                                      child: const Text("Yes"),
                                                      onPressed: () async {
                                                        controller
                                                            .deleteChatRoom(
                                                                chat: chat);
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                    ),
                                                    MaterialButton(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(100),
                                                      ),
                                                      color:
                                                          const Color.fromARGB(
                                                              255,
                                                              137,
                                                              196,
                                                              244),
                                                      child: const Text("No"),
                                                      onPressed: () async {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                    ),
                                                  ],
                                                );
                                              });
                                        },
                                      ),
                                    ),
                                  ],
                                )),
                          ),
                        );
                      }).toList(),
                    );
                }
              },
            ),
          ],
        ),
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
