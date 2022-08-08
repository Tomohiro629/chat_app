import 'package:chat_app/add_group/add_user_controller.dart';
import 'package:chat_app/bottom_navigation_bar/bottom_navigation_bar.dart';
import 'package:chat_app/entity/chat_room.dart';
import 'package:chat_app/entity/chat_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddUserDialog extends ConsumerWidget {
  const AddUserDialog({
    Key? key,
    required this.user,
    required this.chat,
    required this.addUserName,
    required this.currentUserName,
    required this.currentUserImage,
    required this.partnerUserImage,
  }) : super(key: key);
  final ChatUser user;
  final ChatRoom chat;
  final String addUserName;
  final String currentUserName;
  final String currentUserImage;
  final String partnerUserImage;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(addGroupControllerProvider);

    return AlertDialog(
      content: Stack(alignment: Alignment.center, children: [
        CircleAvatar(
          radius: 75.0,
          backgroundColor: Colors.amber[100],
          foregroundImage: NetworkImage(user.imageURL),
          child: const CircularProgressIndicator(
            backgroundColor: Color.fromARGB(255, 3, 104, 7),
          ),
        ),
      ]),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      title: Text("User『 ${user.userName}』 Found! \nChat Start?"),
      actions: <Widget>[
        MaterialButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
          color: const Color.fromARGB(255, 240, 124, 116),
          child: const Text("Start"),
          onPressed: () async {
            controller.setGroup(
              chatRoom: chat,
              groupUserId: user.userId,
              currentUserName: currentUserName,
              partnerUserName: addUserName,
              groupName: user.userName,
              currentUserImage: currentUserImage,
              partnerUserImage: partnerUserImage,
              groupImage: user.imageURL,
            );
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (context) => BottomNavigationBarPage(
                          chatName: '',
                        )),
                (_) => false);
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
  }
}
