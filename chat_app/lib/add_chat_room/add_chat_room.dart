import 'package:chat_app/add_chat_room/add_chat_room_controller.dart';
import 'package:chat_app/base_app_bar.dart';
import 'package:chat_app/repository/user_repository.dart';
import 'package:chat_app/room_select/room_select_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddChatRoomPage extends ConsumerWidget {
  const AddChatRoomPage(
      {Key? key,
      required this.chatId,
      required this.userName,
      required this.lastMessage})
      : super(key: key);
  final String chatId;
  final String userName;
  final String lastMessage;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(addChatRoomControllerProvider);
    final userController = ref.watch(userRepositoryProvider);
    final searchUserName = TextEditingController();

    return Scaffold(
      appBar: const BaseAppBar(
        title: Text("Add Chat Room"),
        widgets: [],
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.fromLTRB(5, 0, 5, 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: 300,
                child: TextFormField(
                  controller: searchUserName,
                  style: const TextStyle(fontSize: 20),
                  decoration: InputDecoration(
                      labelText: 'Search User Name',
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 15,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(100),
                      )),
                ),
              ),
              const SizedBox(
                height: 50.0,
                width: 150.0,
              ),
              SizedBox(
                  height: 50.0,
                  width: 150.0,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                      child: const Text(
                        'Search',
                        style: TextStyle(fontSize: 18),
                      ),
                      onPressed: () async {
                        userController
                            .getUserData(searchUserName.text)
                            .then((QuerySnapshot snapshot) {
                          snapshot.docs.forEach((doc) {
                            if (searchUserName.text == doc.get("userName")) {
                              showDialog(
                                  barrierDismissible: false,
                                  context: context,
                                  builder: (childContext) {
                                    return AlertDialog(
                                      content: Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            Image.network(doc.get("imageURL"))
                                          ]),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(50)),
                                      title: Text(
                                          "${"User『" + doc.get("userName")}』 Found! \nChat Start?"),
                                      actions: <Widget>[
                                        MaterialButton(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                          ),
                                          color: const Color.fromARGB(
                                              255, 240, 124, 116),
                                          child: const Text("Start"),
                                          onPressed: () async {
                                            controller.setChatRoom(
                                              lastMessage: "",
                                              chatName: searchUserName.text,
                                              userId: doc.get("userId"),
                                              sendTime: "",
                                            );
                                            Navigator.pushAndRemoveUntil(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        RoomSelectPage(
                                                          chatName:
                                                              searchUserName
                                                                  .text,
                                                        )),
                                                (_) => false);
                                          },
                                        ),
                                        MaterialButton(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(100),
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
                            } else if (searchUserName != doc.get("userName")) {
                              print("error");
                              showDialog(
                                  barrierDismissible: false,
                                  context: context,
                                  builder: (childContext) {
                                    return AlertDialog(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(50)),
                                      title: const Text("Not Found"),
                                      actions: <Widget>[
                                        MaterialButton(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                          ),
                                          color: const Color.fromARGB(
                                              255, 137, 196, 244),
                                          child: const Text("Back"),
                                          onPressed: () async {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    );
                                  });
                            }
                          });
                        });
                      })),
            ],
          ),
        ),
      ),
    );
  }
}
