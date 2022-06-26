import 'package:chat_app/chat_page/chat_room/chat_room.dart';
import 'package:chat_app/entity/chat.dart';
import 'package:chat_app/room_select/add_chat_room.dart';
import 'package:chat_app/room_select/room_select_controller.dart';
import 'package:chat_app/setting_page/setting_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RoomSelectPage extends ConsumerWidget {
  const RoomSelectPage({
    Key? key,
    required this.chatName,
  }) : super(key: key);
  final String chatName;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _controller = ref.watch(roomSelectControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Room Select"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return const SettingPage(
                  userId: "userId",
                  userName: "userName",
                );
              }));
            },
          ),
        ],
      ),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Column(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
              ),
              StreamBuilder<List<Chat>>(
                stream: _controller.fetchChatRoomStream(),
                builder:
                    (BuildContext context, AsyncSnapshot<List<Chat>> snapshot) {
                  if (snapshot.hasError) {
                    return Text("Error:${snapshot.error}");
                  }
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return Center();
                    default:
                      return ListView(
                          shrinkWrap: true,
                          children: snapshot.data!.map((Chat chat) {
                            return Padding(
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
                                  padding:
                                      const EdgeInsets.fromLTRB(30, 50, 0, 50),
                                  child: ListTile(
                                    title: Text(
                                      "「 ${chat.chatName}」room",
                                      style: const TextStyle(
                                        fontSize: 20,
                                        color:
                                            Color.fromARGB(255, 255, 255, 255),
                                      ),
                                    ),
                                    subtitle: Text(
                                      " 作成日${chat.addTime}",
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color:
                                            Color.fromARGB(255, 56, 255, 238),
                                      ),
                                    ),
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => ChatRoom(
                                              chat: chat,
                                            ),
                                          ));
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
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            100),
                                                  ),
                                                  color: const Color.fromARGB(
                                                      255, 240, 124, 116),
                                                  child: const Text("Yes"),
                                                  onPressed: () async {
                                                    _controller.deleteChatRoom(
                                                        chat: chat);
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                                MaterialButton(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            100),
                                                  ),
                                                  color: const Color.fromARGB(
                                                      255, 137, 196, 244),
                                                  child: const Text("No"),
                                                  onPressed: () async {
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                              ],
                                            );
                                          });
                                    },
                                  ),
                                ),
                              ),
                            );
                          }).toList());
                  }
                },
              ),
            ],
          ),
        ],
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
