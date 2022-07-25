import 'package:chat_app/home_page/home_page.dart';
import 'package:chat_app/service/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LogoutCard extends ConsumerWidget {
  const LogoutCard({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(authServiceProvider);
    return Card(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(100)),
      ),
      child: ListTile(
        title: const Text(
          "Log Out",
        ),
        tileColor: const Color.fromARGB(255, 127, 241, 92),
        trailing: const Icon(Icons.logout),
        leading: ConstrainedBox(
          constraints: const BoxConstraints(
              minHeight: 44, minWidth: 34, maxHeight: 54, maxWidth: 54),
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
                  title: const Text("Log Out!"),
                  content: const Text("Do you want to logout it?"),
                  actions: <Widget>[
                    MaterialButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                      color: const Color.fromARGB(255, 240, 124, 116),
                      child: const Text("Yes"),
                      onPressed: () {
                        controller.logOut();
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
      ),
    );
  }
}
