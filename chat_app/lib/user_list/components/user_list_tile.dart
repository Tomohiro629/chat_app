import 'package:chat_app/entity/chat_user.dart';
import 'package:chat_app/user_list/user_list_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserListTile extends ConsumerWidget {
  const UserListTile({Key? key, required this.user}) : super(key: key);
  final ChatUser user;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userListController = ref.watch(userListProvider);

    return Column(
      children: [
        SizedBox(
          width: 350.0,
          child: CheckboxListTile(
            title: Text(user.userName),
            value: userListController.checked,
            onChanged: (value) {
              userListController.selectCheckBox(value);
            },
            activeColor: Colors.white,
            checkColor: const Color.fromARGB(255, 8, 100, 11),
            controlAffinity: ListTileControlAffinity.trailing,
            secondary: CircleAvatar(
              radius: 25.0,
              foregroundImage: NetworkImage(user.imageURL),
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
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(100)),
              side: BorderSide(color: Colors.lightGreen),
            ),
          ),
        )
      ],
    );
  }
}
