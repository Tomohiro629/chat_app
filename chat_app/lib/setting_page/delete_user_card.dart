import 'package:chat_app/service/auth_service.dart';
import 'package:chat_app/service/user_service.dart';
import 'package:chat_app/user_gate/user_gate_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DeleteUserCard extends ConsumerWidget {
  const DeleteUserCard({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userName = ref.watch(userServiceProvider);
    final userId = ref.watch(authServiceProvider).userId;
    return Card(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(100)),
      ),
      child: ListTile(
        title: const Text(
          "Delete User",
        ),
        tileColor: const Color.fromARGB(255, 127, 241, 92),
        trailing: const Icon(Icons.logout),
        leading: ConstrainedBox(
          constraints: const BoxConstraints(
              minHeight: 44, minWidth: 34, maxHeight: 64, maxWidth: 54),
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(100)),
        ),
        onTap: () async {
          showDialog(
              barrierDismissible: false,
              context: context,
              builder: (childContext) {
                return AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
                  title: const Text("Delete User!"),
                  content: const Text("Do you want to delete it?"),
                  actions: <Widget>[
                    MaterialButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                      color: const Color.fromARGB(255, 240, 124, 116),
                      child: const Text("Yes"),
                      onPressed: () async {
                        await userName.deleteUser(userId);

                        // ignore: use_build_context_synchronously
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const UserGatePage()),
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
              });
        },
      ),
    );
  }
}
