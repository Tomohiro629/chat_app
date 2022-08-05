import 'package:chat_app/entity/chat_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddGroupDialog extends ConsumerWidget {
  const AddGroupDialog({Key? key, required this.user}) : super(key: key);
  final ChatUser user;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AlertDialog(
      backgroundColor: const Color.fromARGB(133, 60, 157, 247),
      content: Stack(
        alignment: Alignment.center,
        children: [TextFormField()],
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      title: const Align(
        alignment: Alignment.center,
        child: Text(
          "  partnerUserName",
          style: TextStyle(color: Colors.white),
        ),
      ),
      actions: <Widget>[
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
