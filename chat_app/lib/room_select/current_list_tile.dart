import 'package:chat_app/chat_page/chat_page.dart';
import 'package:chat_app/entity/chat_room.dart';
import 'package:chat_app/entity/chat_user.dart';
import 'package:chat_app/repository/chat_room_repository.dart';
import 'package:chat_app/repository/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CurrentListTile extends ConsumerWidget {
  final ChatRoom chat;
  final String partnerUserId;

  const CurrentListTile({
    super.key,
    required this.chat,
    required this.partnerUserId,
    required List<String> userIds,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chatRoomController = ref.watch(chatRepositoryProvider);
    final userController = ref.watch(userRepositoryProvider);

    return StreamBuilder<ChatUser?>(
        stream: userController.getPartnerUserData(userId: chat.userIds[1]),
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
                    backgroundColor: const Color.fromARGB(123, 246, 233, 116),
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
                      chat.sendTime != null
                          ? Text(chat.sendTime.toString(),
                              style: const TextStyle(
                                fontSize: 15,
                              ),
                              overflow: TextOverflow.ellipsis)
                          : const Text(""),
                    ],
                  ),
                  subtitle: chat.lastMessage != null
                      ? Text("『" "${chat.lastMessage}" "』",
                          style: const TextStyle(
                            fontSize: 15,
                            color: Color.fromARGB(231, 7, 15, 165),
                          ),
                          overflow: TextOverflow.ellipsis)
                      : const Text(""),
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
                                borderRadius: BorderRadius.circular(50)),
                            title: Text("Delete Room\n『${data.userName}』"),
                            content: const Text("Do you want to Delete it?"),
                            actions: <Widget>[
                              MaterialButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                color: const Color.fromARGB(255, 240, 124, 116),
                                child: const Text("Yes"),
                                onPressed: () async {
                                  chatRoomController.deleteChatRoom(chat: chat);
                                  Navigator.of(context).pop();
                                },
                              ),
                              MaterialButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                color: const Color.fromARGB(255, 137, 196, 244),
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
                      borderRadius: BorderRadius.all(Radius.circular(100)),
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
        }));
  }
}
