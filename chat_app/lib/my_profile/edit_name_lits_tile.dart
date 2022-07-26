import 'package:chat_app/my_profile/my_profile_controller.dart';
import 'package:chat_app/service/auth_service.dart';
import 'package:chat_app/service/user_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EditNameListTile extends ConsumerWidget {
  const EditNameListTile({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(myProfileControllerProvider);
    final userId = ref.watch(authServiceProvider).userId;
    final editName = TextEditingController();

    return ListTile(
      title: const Text("Name:aaaaaaa"),
      trailing: IconButton(
        icon: const Icon(Icons.edit),
        onPressed: () async {
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
                          controller.updataUserName(
                              editUserName: editName.text, userId: userId);
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
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(100)),
          side: BorderSide(color: Colors.lightGreen)),
    );
  }
}
