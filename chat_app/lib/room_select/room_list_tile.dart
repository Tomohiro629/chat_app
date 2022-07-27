import 'package:chat_app/add_chat_room/add_chat_room_controller.dart';
import 'package:chat_app/chat_page/chat_page.dart';
import 'package:chat_app/entity/chat_room.dart';
import 'package:chat_app/repository/chat_room_repository.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RoomListTile extends ConsumerWidget {
  final ChatRoom chat;

  const RoomListTile({
    super.key,
    required this.chat,
    required List<String> userIds,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final addChatRoomController = ref.watch(addChatRoomControllerProvider);
    final chatRoomController = ref.watch(chatRepositoryProvider);
    final editChatRoomName = TextEditingController();

    return Padding(
      //card同士の余白
      padding: const EdgeInsets.all(5),
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
            padding: const EdgeInsets.fromLTRB(70, 10, 0, 10),
            child: Column(
              children: <Widget>[
                Center(
                  child: ListTile(
                    title: Text(
                      chat.chatName,
                      style: const TextStyle(
                        fontSize: 25,
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (childContext) {
                              return AlertDialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50)),
                                title: const Text("Change ChatRoomName?"),
                                content: SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height: 50,
                                  child: TextFormField(
                                      maxLines: 1,
                                      controller: editChatRoomName,
                                      decoration: const InputDecoration(
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 23.0, horizontal: 8.0),
                                        border: OutlineInputBorder(),
                                        labelText: "Text Form",
                                        labelStyle: TextStyle(fontSize: 20),
                                        focusColor: Colors.green,
                                      )),
                                ),
                                actions: <Widget>[
                                  MaterialButton(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                    color: const Color.fromARGB(
                                        255, 240, 124, 116),
                                    child: const Text("Yes"),
                                    onPressed: () async {
                                      try {
                                        addChatRoomController.updateChatRoom(
                                            editChatName: editChatRoomName.text,
                                            roomId: chat.roomId);
                                        Navigator.of(context).pop();
                                      } catch (e) {
                                        print(e);
                                      }
                                    },
                                  ),
                                  MaterialButton(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(100),
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
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ChatPage(
                                    chat: chat,
                                  )));
                    },
                    onLongPress: () {
                      showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (childContext) {
                            return AlertDialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50)),
                              title: Text("Delete Room\n『${chat.chatName}』"),
                              content: const Text("Do you want to Delete it?"),
                              actions: <Widget>[
                                MaterialButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  color:
                                      const Color.fromARGB(255, 240, 124, 116),
                                  child: const Text("Yes"),
                                  onPressed: () async {
                                    chatRoomController.deleteChatRoom(
                                        chat: chat);
                                    Navigator.of(context).pop();
                                  },
                                ),
                                MaterialButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  color:
                                      const Color.fromARGB(255, 137, 196, 244),
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
              ],
            )),
      ),
    );
  }
}
