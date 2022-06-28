import 'package:chat_app/entity/user.dart';
import 'package:chat_app/home_page/home_page.dart';
import 'package:chat_app/setting_page/setting_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingPage extends ConsumerWidget {
  const SettingPage({
    Key? key,
    required this.userId,
    required this.userName,
  }) : super(key: key);
  final String userId;
  final String userName;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _controller = ref.watch(settingControllerProvider);
    final textEditName = TextEditingController();

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
                                  await _controller.deleteUser();
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
                  title: const Text("Edit User Name"),
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
                  onTap: () {
                    showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (childContext) {
                          return AlertDialog(
                            insetPadding: const EdgeInsets.all(8),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50)),
                            title: const Text("Edit User Name"),
                            content: SizedBox(
                                width: 500,
                                child: TextField(
                                  keyboardType: TextInputType.multiline,
                                  maxLines: null,
                                  controller: textEditName,
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 15.0, horizontal: 10.0),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                    labelText: "Text Form",
                                    labelStyle: const TextStyle(fontSize: 20),
                                    focusColor: Colors.green,
                                  ),
                                )),
                            actions: <Widget>[
                              MaterialButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                color: const Color.fromARGB(255, 240, 124, 116),
                                child: const Text("OK"),
                                onPressed: () async {
                                  try {
                                    await _controller.addUser(
                                      userNameText: textEditName.text,
                                      userId: userId,
                                    );
                                    textEditName.clear();
                                  } catch (e) {
                                    print(e);
                                  }
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
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: StreamBuilder<List<Users>>(
              stream: _controller.fetchUsersStream(userId),
              builder:
                  (BuildContext context, AsyncSnapshot<List<Users>> snapshot) {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return Center(
                      child: Stack(children: const [
                        CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                              Color.fromARGB(255, 6, 121, 11)),
                          backgroundColor: Color.fromARGB(255, 48, 185, 53),
                        ),
                      ]),
                    );
                  default:
                    return ListView(
                      shrinkWrap: true,
                      children: snapshot.data!.map((Users user) {
                        return Align(
                          child: Card(
                            child: Text("${user.userName}でログイン中"),
                          ),
                        );
                      }).toList(),
                    );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
