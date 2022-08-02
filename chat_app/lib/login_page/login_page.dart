import 'package:chat_app/base_app_bar.dart';
import 'package:chat_app/login_page/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final isObscureProvider = StateProvider<bool>((ref) => true);

class LoginPage extends ConsumerWidget {
  LoginPage({Key? key}) : super(key: key);

  String infoText = '';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(loginControllerProvider);
    final isObscure = ref.watch(isObscureProvider);

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
                  onPressed: () {
                    if (loginMailAddress.isNotEmpty &&
                        loginPassword.isNotEmpty) {
                      controller.loginUser(
                          email: loginMailAddress, password: loginPassword);
                      Navigator.pop(context);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Log in error"),
                          backgroundColor: Colors.red,
                        ),
                      );
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
