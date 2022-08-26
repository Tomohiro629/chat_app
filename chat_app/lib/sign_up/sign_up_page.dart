import 'package:chat_app/base_app_bar.dart';
import 'package:chat_app/sign_up/sign_up_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignUpPage extends ConsumerWidget {
  SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(signUpControllerProvider);

    String newEmailAddress = "";
    String newPassword = "";

    return Scaffold(
      appBar: const BaseAppBar(
        title: Text("Sign up"),
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
                  style: const TextStyle(fontSize: 20),
                  decoration: InputDecoration(
                    labelText: ' Mail',
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 15,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                  onChanged: (String value) {
                    newEmailAddress = value;
                  },
                ),
              ),
              const SizedBox(
                height: 25.0,
              ),
              SizedBox(
                width: 300,
                child: TextFormField(
                  keyboardType: TextInputType.visiblePassword,
                  style: const TextStyle(fontSize: 20),
                  decoration: InputDecoration(
                    labelText: ' Password(8~20)',
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 15,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                  obscureText: true,
                  maxLength: 20,
                  onChanged: (String value) {
                    newPassword = value;
                  },
                ),
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
                    'Sign up',
                    style: TextStyle(fontSize: 18),
                  ),
                  onPressed: () async {
                    if (newEmailAddress.isNotEmpty && newPassword.isNotEmpty) {
                      await controller.signUpUser(
                        newEmail: newEmailAddress,
                        newPassword: newPassword,
                      );
                      Navigator.pop(context);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Sign up error"),
                        backgroundColor: Colors.red,
                      ));
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
