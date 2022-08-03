import 'package:chat_app/edit_profile/edit_profile_page.dart';
import 'package:chat_app/entity/chat_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CurrentUserDateDialog extends ConsumerWidget {
  const CurrentUserDateDialog({Key? key, required this.user}) : super(key: key);
  final ChatUser user;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AlertDialog(
      backgroundColor: const Color.fromARGB(131, 76, 175, 79),
      content: Stack(
        alignment: Alignment.center,
        children: [
          CircleAvatar(
            radius: 75.0,
            backgroundColor: Colors.amber[100],
            foregroundImage: NetworkImage(user.imageURL),
            child: const CircularProgressIndicator(
              backgroundColor: Color.fromARGB(255, 3, 104, 7),
            ),
          ),
        ],
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      title: Align(
        alignment: Alignment.center,
        child: Text(
          user.userName,
          style: const TextStyle(color: Colors.white),
        ),
      ),
      actions: <Widget>[
        MaterialButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
          color: const Color.fromARGB(255, 240, 124, 116),
          child: const Text("Edit"),
          onPressed: () async {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => EditProfilePage(
                        imageURL: user.imageURL,
                        userName: user.userName,
                      )),
            );
          },
        ),
        MaterialButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
          color: const Color.fromARGB(255, 137, 196, 244),
          child: const Text("Back"),
          onPressed: () async {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
