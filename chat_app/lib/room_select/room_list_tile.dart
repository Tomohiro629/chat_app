import 'package:chat_app/add_chat_room/add_chat_room_controller.dart';
import 'package:chat_app/chat_page/chat_page.dart';
import 'package:chat_app/entity/chat_room.dart';
import 'package:chat_app/entity/chat_user.dart';
import 'package:chat_app/repository/chat_room_repository.dart';
import 'package:chat_app/repository/user_repository.dart';
import 'package:chat_app/service/auth_service.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RoomListTile extends ConsumerWidget {
  final ChatRoom chat;
  final String partnerUserId;

  const RoomListTile({
    super.key,
    required this.chat,
    required this.partnerUserId,
    required List<String> userIds,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final addChatRoomController = ref.watch(addChatRoomControllerProvider);
    final chatRoomController = ref.watch(chatRepositoryProvider);
    final userController = ref.watch(userRepositoryProvider);
    final editChatRoomName = TextEditingController();

    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(40.0)),
      child: Padding(
        //cardの幅
        padding: const EdgeInsets.all(5.0),
        child: chat.userIds[0] == ref.watch(authServiceProvider).userId
            ? StreamBuilder<ChatUser?>(
                stream:
                    userController.getPartnerUserData(userId: chat.userIds[1]),
                builder: ((context, snapshot) {
                  final data = snapshot.data;
                  if (snapshot.hasData) {
                    return Column(children: [
                      SizedBox(
                        width: 350.0,
                        child: ListTile(
                          leading: CircleAvatar(
                            radius: 25.0,
                            foregroundImage: NetworkImage(data!.imageURL),
                            backgroundColor:
                                const Color.fromARGB(123, 246, 233, 116),
                            child: const SizedBox(
                              width: 20.0,
                              height: 20.0,
                              child: CircularProgressIndicator(
                                backgroundColor: Color.fromARGB(255, 3, 104, 7),
                                strokeWidth: 2.0,
                              ),
                            ),
                          ),
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                data.userName,
                                style: const TextStyle(
                                  fontSize: 20,
                                  color: Color.fromARGB(255, 7, 205, 30),
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(chat.sendTime.toString(),
                                  style: const TextStyle(
                                    fontSize: 15,
                                  ),
                                  overflow: TextOverflow.ellipsis),
                            ],
                          ),
                          subtitle:
                              Text("『" "${chat.lastMessage.toString()}" "』",
                                  style: const TextStyle(
                                    fontSize: 15,
                                    color: Color.fromARGB(231, 7, 15, 165),
                                  ),
                                  overflow: TextOverflow.ellipsis),
                          trailing: IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () {
                              showDialog(
                                  barrierDismissible: false,
                                  context: context,
                                  builder: (childContext) {
                                    return AlertDialog(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(50)),
                                      title: const Text("Change ChatRoomName?"),
                                      content: SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height: 50,
                                        child: TextFormField(
                                            maxLines: 1,
                                            controller: editChatRoomName,
                                            decoration: const InputDecoration(
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      vertical: 23.0,
                                                      horizontal: 8.0),
                                              border: OutlineInputBorder(),
                                              labelText: "Text Form",
                                              labelStyle:
                                                  TextStyle(fontSize: 20),
                                              focusColor: Colors.green,
                                            )),
                                      ),
                                      actions: <Widget>[
                                        MaterialButton(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                          ),
                                          color: const Color.fromARGB(
                                              255, 240, 124, 116),
                                          child: const Text("Yes"),
                                          onPressed: () async {
                                            try {
                                              addChatRoomController
                                                  .updateChatRoom(
                                                      editChatName:
                                                          editChatRoomName.text,
                                                      roomId: chat.roomId);
                                              Navigator.of(context).pop();
                                            } catch (e) {
                                              print(e);
                                            }
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
                            },
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ChatPage(
                                          chat: chat,
                                          userImageURL: data.imageURL,
                                        )));
                          },
                          onLongPress: () {
                            showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (childContext) {
                                  return AlertDialog(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(50)),
                                    title:
                                        Text("Delete Room\n『${data.userName}』"),
                                    content:
                                        const Text("Do you want to Delete it?"),
                                    actions: <Widget>[
                                      MaterialButton(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                        ),
                                        color: const Color.fromARGB(
                                            255, 240, 124, 116),
                                        child: const Text("Yes"),
                                        onPressed: () async {
                                          chatRoomController.deleteChatRoom(
                                              chat: chat);
                                          Navigator.of(context).pop();
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
                          },
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(100)),
                              side: BorderSide(color: Colors.lightGreen)),
                        ),
                      ),
                    ]);
                  }
                  if (snapshot.hasError) {
                    return const Dialog(
                      child: Text("Error"),
                    );
                  }
                  return const Center(child: CircularProgressIndicator());
                }))
            : StreamBuilder<ChatUser?>(
                stream:
                    userController.getPartnerUserData(userId: chat.userIds[0]),
                builder: ((context, snapshot) {
                  final data = snapshot.data;
                  if (snapshot.hasData) {
                    return Column(children: [
                      SizedBox(
                        width: 350.0,
                        child: ListTile(
                          leading: CircleAvatar(
                            radius: 25.0,
                            foregroundImage: NetworkImage(data!.imageURL),
                            backgroundColor:
                                const Color.fromARGB(123, 246, 233, 116),
                            child: const SizedBox(
                              width: 20.0,
                              height: 20.0,
                              child: CircularProgressIndicator(
                                backgroundColor: Color.fromARGB(255, 3, 104, 7),
                                strokeWidth: 2.0,
                              ),
                            ),
                          ),
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                data.userName,
                                style: const TextStyle(
                                  fontSize: 20,
                                  color: Color.fromARGB(255, 7, 205, 30),
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(chat.sendTime.toString(),
                                  style: const TextStyle(
                                    fontSize: 15,
                                  ),
                                  overflow: TextOverflow.ellipsis),
                            ],
                          ),
                          subtitle:
                              Text("『" "${chat.lastMessage.toString()}" "』",
                                  style: const TextStyle(
                                    fontSize: 15,
                                    color: Color.fromARGB(231, 7, 15, 165),
                                  ),
                                  overflow: TextOverflow.ellipsis),
                          trailing: IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () {
                              showDialog(
                                  barrierDismissible: false,
                                  context: context,
                                  builder: (childContext) {
                                    return AlertDialog(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(50)),
                                      title: const Text("Change ChatRoomName?"),
                                      content: SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height: 50,
                                        child: TextFormField(
                                            maxLines: 1,
                                            controller: editChatRoomName,
                                            decoration: const InputDecoration(
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      vertical: 23.0,
                                                      horizontal: 8.0),
                                              border: OutlineInputBorder(),
                                              labelText: "Text Form",
                                              labelStyle:
                                                  TextStyle(fontSize: 20),
                                              focusColor: Colors.green,
                                            )),
                                      ),
                                      actions: <Widget>[
                                        MaterialButton(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                          ),
                                          color: const Color.fromARGB(
                                              255, 240, 124, 116),
                                          child: const Text("Yes"),
                                          onPressed: () async {
                                            try {
                                              addChatRoomController
                                                  .updateChatRoom(
                                                      editChatName:
                                                          editChatRoomName.text,
                                                      roomId: chat.roomId);
                                              Navigator.of(context).pop();
                                            } catch (e) {
                                              print(e);
                                            }
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
                            },
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ChatPage(
                                          chat: chat,
                                          userImageURL: data.imageURL,
                                        )));
                          },
                          onLongPress: () {
                            showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (childContext) {
                                  return AlertDialog(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    title:
                                        Text("Delete Room\n『${data.userName}』"),
                                    content:
                                        const Text("Do you want to Delete it?"),
                                    actions: <Widget>[
                                      MaterialButton(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                        ),
                                        color: const Color.fromARGB(
                                            255, 240, 124, 116),
                                        child: const Text("Yes"),
                                        onPressed: () async {
                                          chatRoomController.deleteChatRoom(
                                              chat: chat);
                                          Navigator.of(context).pop();
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
                          },
                          shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(100)),
                            side: BorderSide(color: Colors.lightGreen),
                          ),
                        ),
                      ),
                    ]);
                  }
                  if (snapshot.hasError) {
                    return const Dialog(
                      child: Text("Error"),
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                })),
      ),
    );
  }
}
