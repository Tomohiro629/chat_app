import 'package:chat_app/entity/authentication_error.dart';
import 'package:chat_app/sign_in/sign_in_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final isObscureProvider = StateProvider<bool>((ref) => true);

class SignInPage extends ConsumerWidget {
  SignInPage({Key? key}) : super(key: key);

  final authError = AuthenticationError();
  final txetEdit = TextEditingController();
  UserCredential? result;
  User? user;

  String infoText = '';
  bool passOK = true;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _controller = ref.watch(signInControllerProvider);
    final _isObscure = ref.watch(isObscureProvider);
    final newEmailEdit = TextEditingController();
    final newPasswordEdit = TextEditingController();
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text("Registertion Page")),
      body: Center(
        child: Container(
          padding: const EdgeInsets.fromLTRB(5, 0, 5, 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
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
              Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 15),
                child: Text(
                  infoText,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
              TextFormField(
                controller: newPasswordEdit,
                keyboardType: TextInputType.visiblePassword,
                style: const TextStyle(fontSize: 20),
                decoration: InputDecoration(
                  labelText: ' Password(8~20)',
                  suffixIcon: IconButton(
                    icon: Icon(_isObscure
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined),
                    onPressed: () {
                      ref.read(isObscureProvider.state).state = !_isObscure;
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
                obscureText: _isObscure,
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
                        await _controller.signInUser(
                          newEmail: newEmailEdit.text,
                          newPassword: newPasswordEdit.text,
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
