import 'package:chat_app/chat_page/chat_page.dart';
import 'package:chat_app/entity/chat_room.dart';
import 'package:chat_app/entity/chat_user.dart';
import 'package:chat_app/gourp_page/group_page.dart';
import 'package:chat_app/repository/chat_room_repository.dart';
import 'package:chat_app/repository/user_repository.dart';
import 'package:chat_app/service/common_method.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GroupListTile extends ConsumerWidget {
  final ChatRoom chat;
  final String partnerUserId;
  final String partnerUserName;
  final String partnerUserImage;

  const GroupListTile({
    super.key,
    required this.chat,
    required this.partnerUserId,
    required this.partnerUserName,
    required this.partnerUserImage,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chatRoomController = ref.watch(chatRepositoryProvider);
    final userController = ref.watch(userRepositoryProvider);

    return StreamBuilder<ChatUser?>(
        stream: userController.getPartnerUserData(userId: partnerUserId),
        builder: ((context, snapshot) {
          final user = snapshot.data;
          if (snapshot.hasData) {
            return Column(children: [
              SizedBox(
                width: 400.0,
                child: ListTile(
                  leading: const CircleAvatar(
                    radius: 25.0,
                    foregroundImage: NetworkImage(
                        "https://th.bing.com/th/id/OIP.3dYlegQ0F8Kx8suoY52NNAHaLH?w=125&h=187&c=7&r=0&o=5&dpr=1.5&pid=1.7"),
                    backgroundColor: Color.fromARGB(123, 246, 233, 116),
                    child: SizedBox(
                      width: 20.0,
                      height: 20.0,
                      child: CircularProgressIndicator(
                        backgroundColor: Color.fromARGB(255, 3, 104, 7),
                        strokeWidth: 2.0,
                      ),
                    ),
                  ),
                  title: Stack(
                    children: [
                      Text(
                        '${chat.userNames[0]}/'
                        '${chat.userNames[1]}/\n'
                        '${chat.userNames[2]}',
                        style: const TextStyle(
                          fontSize: 15,
                          color: Color.fromARGB(255, 7, 205, 30),
                        ),
                        overflow: TextOverflow.clip,
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: chat.timeStamp != null
                            ? Text(getDateString(chat.timeStamp!),
                                style: const TextStyle(
                                  fontSize: 15,
                                ),
                                overflow: TextOverflow.ellipsis)
                            : const Text(""),
                      ),
                    ],
                  ),
                  subtitle: chat.lastMessage != null
                      ? Text(chat.lastMessage.toString(),
                          style: const TextStyle(
                            fontSize: 15,
                            color: Color.fromARGB(177, 7, 139, 165),
                          ),
                          overflow: TextOverflow.ellipsis)
                      : const Text(
                          "",
                        ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => chat.userImages[2].isEmpty
                                ? ChatPage(
                                    chat: chat,
                                    imageURL: user!.imageURL,
                                    roomName: user.userName,
                                    currentUserImage: "",
                                  )
                                : GroupPage(
                                    chat: chat,
                                    imageURL: user!.imageURL,
                                    roomName: user.userName,
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
                            title: const Text("Delete Group Room』"),
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
        }));
  }
}
