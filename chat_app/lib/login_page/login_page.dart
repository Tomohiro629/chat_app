import 'package:chat_app/base_app_bar.dart';
import 'package:chat_app/login_page/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(loginControllerProvider);

    String loginMailAddress = "";
    String loginPassword = "";

    return Scaffold(
      appBar: const BaseAppBar(
        title: Text("Log in"),
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
                  keyboardType: TextInputType.emailAddress,
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
                    loginMailAddress = value;
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
                    labelText: ' Password(6~20)',
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 15,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                  maxLength: 20,
                  obscureText: true,
                  onChanged: (String value) {
                    loginPassword = value;
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
                    'Log in',
                    style: TextStyle(fontSize: 18),
                  ),
                  onPressed: () async {
                    try {
                      await controller.loginUser(
                          email: loginMailAddress, password: loginPassword);
                      // ignore: use_build_context_synchronously
                      Navigator.pop(context);
                    } catch (e) {
                      if (e.toString() ==
                          "[firebase_auth/unknown] Given String is empty or null") {
                        controller.setErrorMessage(
                            "Email address or password is missing");
                      } else if (e.toString() ==
                          "[firebase_auth/user-not-found] There is no user record corresponding to this identifier. The user may have been deleted.") {
                        controller.setErrorMessage(
                            "There is no user record corresponding to this identifier.\n The user may have been deleted.");
                      } else {
                        controller.setErrorMessage("Login error");
                      }
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(controller.errorMessage),
                        backgroundColor: Colors.red,
                        duration: const Duration(seconds: 1),
                      ));
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
