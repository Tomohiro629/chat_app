import 'package:chat_app/base_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddUserPage extends ConsumerWidget {
  const AddUserPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final partnerUserId = TextEditingController();
    return Scaffold(
      appBar: const BaseAppBar(
        title: Text("Add User Page"),
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
                  controller: partnerUserId,
                  style: const TextStyle(fontSize: 20),
                  decoration: InputDecoration(
                      labelText: 'Chat Room Name',
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
                      'Add',
                      style: TextStyle(fontSize: 18),
                    ),
                    onPressed: () async {
                      Navigator.pop(
                        context,
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
