import 'package:chat_app/base_app_bar.dart';
import 'package:chat_app/sign_up/sign_up_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final isObscureProvider = StateProvider<bool>((ref) => true);

class SignUpPage extends ConsumerWidget {
  SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(signUpControllerProvider);
    final isObscure = ref.watch(isObscureProvider);

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
                    suffixIcon: IconButton(
                      icon: Icon(isObscure
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined),
                      onPressed: () {
                        ref.read(isObscureProvider.state).state = !isObscure;
                      },
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                  obscureText: isObscure,
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
                    try {
                      await controller.signUpUser(
                        newEmail: newEmailAddress,
                        newPassword: newPassword,
                      );
                      // ignore: use_build_context_synchronously
                      Navigator.pop(context);
                    } catch (e) {
                      if (e.toString() ==
                          "[firebase_auth/unknown] Given String is empty or null") {
                        controller.setErrorMessage(
                            "Email address or password is missing");
                      } else if (newPassword.length < 8) {
                        controller.setErrorMessage(
                            "Password must be at least 8 characters long");
                        // ignore: unrelated_type_equality_checks
                      } else if (e.toString() ==
                          "[firebase_auth/email-already-in-use] The email address is already in use by another account.") {
                        controller.setErrorMessage(
                            "The email address is already in use by another account.");
                      } else {
                        controller.setErrorMessage("Sign up error");
                      }
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(controller.errorMessage),
                        backgroundColor: Colors.red,
                        duration: const Duration(seconds: 1),
                      ));
                      print(e.toString());
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
