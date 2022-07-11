import 'package:chat_app/home_page/home_page.dart';
import 'package:chat_app/service/auth_service.dart';
import 'package:chat_app/service/user_service.dart';
import 'package:chat_app/setting_page/setting_controller.dart';
import 'package:chat_app/user_gate/user_gate_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingPage extends ConsumerWidget {
  const SettingPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _controller = ref.watch(settingControllerProvider);
    final userName = ref.watch(userServiceProvider);
    final userId = ref.watch(authServiceProvider).userId;
    final editName = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Settings"),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Column(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
              ),
              Card(
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
                        minHeight: 44,
                        minWidth: 34,
                        maxHeight: 64,
                        maxWidth: 54),
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
                                onPressed: () async {
                                  await _controller.logOut();

                                  await Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return const HomePage();
                                      },
                                    ),
                                  );
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
              ),
              Card(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(100)),
                ),
                child: ListTile(
                  title: const Text(
                    "Edit UserName",
                  ),
                  tileColor: const Color.fromARGB(255, 127, 241, 92),
                  trailing: const Icon(Icons.edit),
                  leading: ConstrainedBox(
                    constraints: const BoxConstraints(
                        minHeight: 44,
                        minWidth: 34,
                        maxHeight: 64,
                        maxWidth: 54),
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
                            title: const Text("Change Name?"),
                            content: SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: 50,
                              child: TextFormField(
                                  maxLines: 1,
                                  controller: editName,
                                  decoration: const InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 23.0, horizontal: 8.0),
                                    border: OutlineInputBorder(),
                                    labelText: "Text Form",
                                    labelStyle: TextStyle(fontSize: 20),
                                    focusColor: Colors.green,
                                  )),
                            ),
                            actions: <Widget>[
                              MaterialButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                color: const Color.fromARGB(255, 240, 124, 116),
                                child: const Text("Yes"),
                                onPressed: () async {
                                  try {
                                    await userName.addUser(
                                        userNameText: editName.text,
                                        userId: userId);
                                    Navigator.of(context).pop();
                                  } catch (e) {
                                    print(e);
                                  }
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
              ),
              Card(
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
                        minHeight: 44,
                        minWidth: 34,
                        maxHeight: 64,
                        maxWidth: 54),
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
                                          builder: (context) =>
                                              const UserGatePage()),
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
              ),
            ],
          ),
        ],
      ),
    );
  }
}
