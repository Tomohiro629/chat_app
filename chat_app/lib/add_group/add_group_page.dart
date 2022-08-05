import 'package:chat_app/add_chat_room/components/search_user_dialog.dart';
import 'package:chat_app/add_group/components/search_users_dialog.dart';
import 'package:chat_app/base_app_bar.dart';
import 'package:chat_app/repository/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddGroupPage extends ConsumerWidget {
  const AddGroupPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userController = ref.watch(userRepositoryProvider);
    final member1 = TextEditingController();
    final member2 = TextEditingController();
    final member3 = TextEditingController();

    return Scaffold(
      appBar: const BaseAppBar(
        title: Text("Add Group"),
        widgets: [],
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.fromLTRB(5, 0, 5, 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              SizedBox(
                width: 300,
                child: TextFormField(
                  controller: member1,
                  style: const TextStyle(fontSize: 20),
                  decoration: InputDecoration(
                      labelText: 'Add Group User Name',
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 15,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(100),
                      )),
                ),
              ),
              SizedBox(
                width: 300,
                child: TextFormField(
                  controller: member2,
                  style: const TextStyle(fontSize: 20),
                  decoration: InputDecoration(
                      labelText: 'Add Group User Name',
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 15,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(100),
                      )),
                ),
              ),
              SizedBox(
                width: 300,
                child: TextFormField(
                  controller: member3,
                  style: const TextStyle(fontSize: 20),
                  decoration: InputDecoration(
                      labelText: 'Add Group User Name',
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 15,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(100),
                      )),
                ),
              ),
              SizedBox(
                width: 150.0,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                    child: const Text(
                      'Set',
                      style: TextStyle(fontSize: 18),
                    ),
                    onPressed: () async {
                      final user =
                          await userController.searchUserData(member1.text);
                      final user1 =
                          await userController.searchUserData(member2.text);
                      final user2 =
                          await userController.searchUserData(member3.text);

                      if (user != null && user1 != null && user2 != null) {
                        showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (childContext) {
                              return SearchUsersDialog(
                                user: user,
                              );
                            });
                      } else {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text("User Not Found"),
                          backgroundColor: Colors.red,
                        ));
                      }
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
