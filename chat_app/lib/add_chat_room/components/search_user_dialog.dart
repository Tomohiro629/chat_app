import 'package:chat_app/add_chat_room/add_chat_room_controller.dart';
import 'package:chat_app/entity/chat_user.dart';
import 'package:chat_app/repository/user_repository.dart';
import 'package:chat_app/room_select/room_select_page.dart';
import 'package:chat_app/service/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchUserDialog extends ConsumerWidget {
  const SearchUserDialog({
    Key? key,
    required this.user,
    required this.searchUserName,
    required this.currentUserName,
  }) : super(key: key);
  final ChatUser user;
  final String searchUserName;
  final String currentUserName;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(addChatRoomControllerProvider);
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
            controller.setChatRoom(
              partnerId: user.userId,
              groupUserId: "",
              currentUserName: currentUserName, //ログインユーザ名
              partnerUserName: user.userName,
              currentUserImage: currentUser.imageURL,
              partnerUserImage: user.imageURL,
            );
            // ignore: use_build_context_synchronously
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (context) => RoomSelectPage(
                          partnerUserName: user.userName,
                          partnerUserImage: user.imageURL,
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
