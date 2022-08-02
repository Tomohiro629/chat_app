import 'package:chat_app/add_chat_room/components/search_user_dialog.dart';
import 'package:chat_app/base_app_bar.dart';
import 'package:chat_app/repository/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddChatRoomPage extends ConsumerWidget {
  const AddChatRoomPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userController = ref.watch(userRepositoryProvider);
    final searchUserName = TextEditingController();

    return Scaffold(
      appBar: const BaseAppBar(
        title: Text("Add Chat"),
        widgets: [],
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.fromLTRB(5, 0, 5, 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: 300,
                child: TextFormField(
                  controller: searchUserName,
                  style: const TextStyle(fontSize: 20),
                  decoration: InputDecoration(
                      labelText: 'Search User Name',
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 15,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(100),
                      )),
                ),
              ),
              const SizedBox(
                height: 50.0,
                width: 150.0,
              ),
              SizedBox(
                  height: 50.0,
                  width: 150.0,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                      child: const Text(
                        'Search',
                        style: TextStyle(fontSize: 18),
                      ),
                      onPressed: () async {
                        final user = await userController
                            .searchUserData(searchUserName.text);

                        if (user != null) {
                          showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (childContext) {
                                return SearchUserDialog(
                                  user: user,
                                  searchUserName: searchUserName.text,
                                );
                              });
                        } else {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text("User Not Found"),
                            backgroundColor: Colors.red,
                          ));
                        }
                      })),
            ],
          ),
        ),
      ),
    );
  }
}
