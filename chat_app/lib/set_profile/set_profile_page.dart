import 'package:chat_app/service/auth_service.dart';
import 'package:chat_app/service/user_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SetProfilePage extends ConsumerWidget {
  const SetProfilePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _service = ref.watch(userServiceProvider);
    final nameEdit = TextEditingController();
    final newUserId = ref.watch(authServiceProvider).userId;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Set Profile Page"),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.fromLTRB(5, 0, 5, 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                controller: nameEdit,
                style: const TextStyle(fontSize: 20),
                decoration: InputDecoration(
                    labelText: 'Name',
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 15,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100),
                    )),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 5, bottom: 15),
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
                    'Set',
                    style: TextStyle(fontSize: 18),
                  ),
                  onPressed: () async {
                    try {
                      _service.addUser(
                        userNameText: nameEdit.text,
                        userId: newUserId,
                      );
                      Navigator.pop(
                        context,
                      );
                    } catch (e) {
                      print(e);
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
