import 'package:chat_app/add_group/add_user_controller.dart';
import 'package:chat_app/entity/chat_room.dart';
import 'package:chat_app/entity/chat_user.dart';
import 'package:chat_app/repository/user_repository.dart';
import 'package:chat_app/room_select/room_select_page.dart';
import 'package:chat_app/service/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddUserDialog extends ConsumerWidget {
  const AddUserDialog({
    Key? key,
    required this.user,
    required this.chat,
    required this.addUserName,
    required this.currentUserName,
    required this.partnerUserImage,
  }) : super(key: key);
  final ChatUser user;
  final ChatRoom chat;
  final String addUserName;
  final String currentUserName;
  final String partnerUserImage;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(addGroupControllerProvider);
    final userController = ref.watch(userRepositoryProvider);

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
            final currentUser = await userController.getUserDate(
                userId: ref.watch(authServiceProvider).userId);
            controller.setGroup(
              chatRoom: chat,
              groupUserId: user.userId,
              currentUserName: currentUserName,
              partnerUserName: addUserName,
              groupName: user.userName,
              currentUserImage: currentUser.imageURL,
              partnerUserImage: partnerUserImage,
              groupImage: user.imageURL,
            );
            // ignore: use_build_context_synchronously
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (context) => RoomSelectPage(
                          partnerUserName: addUserName,
                          partnerUserImage: partnerUserImage,
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
