import 'package:chat_app/service/auth_service.dart';
import 'package:chat_app/service/user_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EditUserNameCard extends ConsumerWidget {
  const EditUserNameCard({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userName = ref.watch(userServiceProvider);
    final userId = ref.watch(authServiceProvider).userId;
    final editName = TextEditingController();
    return Card(
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
                          userName.addUser(
                            userNameText: editName.text,
                            userId: userId,
                            imageURL: '',
                          );
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
    );
  }
}
