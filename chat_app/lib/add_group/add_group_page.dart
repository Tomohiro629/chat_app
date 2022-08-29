import 'package:chat_app/add_group/components/add_users_dialog.dart';
import 'package:chat_app/base_app_bar.dart';
import 'package:chat_app/entity/chat_room.dart';
import 'package:chat_app/repository/user_repository.dart';
import 'package:chat_app/service/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddGroupPage extends ConsumerWidget {
  const AddGroupPage(
      {Key? key,
      required this.chat,
      required this.addGroupUserName,
      required this.partnerUserImage})
      : super(key: key);
  final ChatRoom chat;
  final String addGroupUserName;
  final String partnerUserImage;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userController = ref.watch(userRepositoryProvider);
    final addUserName = TextEditingController();

    return Scaffold(
      appBar: const BaseAppBar(
        title: Text("Add Group"),
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
                  controller: addUserName,
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
              const SizedBox(
                height: 50.0,
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
                        final currentUser = await userController.getUserDate(
                            userId: ref.watch(authServiceProvider).userId);
                        final user = await userController
                            .searchUserData(addUserName.text);
                        if (user != null) {
                          showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (childContext) {
                                return AddUserDialog(
                                  chat: chat,
                                  user: user,
                                  currentUserName: currentUser.userName,
                                  addUserName: addGroupUserName,
                                  partnerUserImage: partnerUserImage,
                                );
                              });
                        } else {
                          // ignore: use_build_context_synchronously
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text("There are some missing items"),
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
