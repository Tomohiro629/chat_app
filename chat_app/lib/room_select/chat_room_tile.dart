import 'package:chat_app/chat_page/build_chat.dart';
import 'package:chat_app/entity/chat_room.dart';
import 'package:flutter/material.dart';

class ChatRoomTile extends StatelessWidget {
  final ChatRoom chat;

  const ChatRoomTile({super.key, required this.chat});

  @override
  Widget build(BuildContext context) {
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
            padding: const EdgeInsets.fromLTRB(30, 50, 0, 50),
            child: Column(
              children: <Widget>[
                Center(
                  child: ListTile(
                    title: Text(
                      "「 ${chat.chatName}」room",
                      style: const TextStyle(
                        fontSize: 20,
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                    ),
                    subtitle: Text(
                      " 作成日${chat.addTime}",
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color.fromARGB(255, 202, 224, 7),
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  BuildChat(chat: chat, userId: "", uid: "")));
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
                                    // controller.deleteChatRoom(chat: chat);
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
