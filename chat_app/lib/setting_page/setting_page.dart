import 'package:chat_app/home_page.dart';
import 'package:chat_app/setting_page/setting_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingPage extends ConsumerWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _controller = ref.watch(settingControllerProvider);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Settings"),
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text("Log Out"),
            trailing: IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () async {
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
          ListTile(),
        ],
      ),
    );
  }
}
