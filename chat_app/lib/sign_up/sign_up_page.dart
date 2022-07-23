import 'package:chat_app/base_app_bar.dart';
import 'package:chat_app/entity/authentication_error.dart';
import 'package:chat_app/sign_up/sign_up_controller.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final isObscureProvider = StateProvider<bool>((ref) => true);

class SignUpPage extends ConsumerWidget {
  SignUpPage({Key? key}) : super(key: key);

  final authError = AuthenticationError();
  final txetEdit = TextEditingController();
  UserCredential? result;
  User? user;

  String infoText = '';
  bool passOK = true;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(signUpControllerProvider);
    final isObscure = ref.watch(isObscureProvider);
    final newEmailEdit = TextEditingController();
    String newPassword = "";

    return Scaffold(
      appBar: const BaseAppBar(
        title: Text("Registertion Page"),
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
                  controller: newEmailEdit,
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
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 15),
                child: Text(
                  infoText,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
              SizedBox(
                width: 300,
                child: TextFormField(
                  keyboardType: TextInputType.visiblePassword,
                  style: const TextStyle(fontSize: 20),
                  decoration: InputDecoration(
                    labelText: ' Password(8~20)',
                    suffixIcon: IconButton(
                      icon: Icon(isObscure
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined),
                      onPressed: () {
                        ref.read(isObscureProvider.state).state = !isObscure;
                      },
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 15,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                  obscureText: isObscure,
                  onChanged: (String value) {
                    newPassword = value;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 15),
                child: Text(
                  infoText,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                // メッセージ表示
                child: Text(infoText),
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
                    'Sign Up',
                    style: TextStyle(fontSize: 18),
                  ),
                  onPressed: () async {
                    if (passOK) {
                      try {
                        await controller.signUpUser(
                          newEmail: newEmailEdit.text,
                          newPassword: newPassword,
                        );
                        Navigator.pop(context);
                      } on FirebaseAuthException catch (e) {
                        print(e);
                        infoText = authError.registerErrorMsg(e.code);
                      }
                    } else {
                      infoText = "Password must be at least 8 characters long";
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
