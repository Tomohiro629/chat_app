import 'package:chat_app/room_select/room_select_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  final FirebaseAuth auth = FirebaseAuth.instance;
  String infoText = '';
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Login Page"),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.fromLTRB(5, 0, 5, 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                style: const TextStyle(fontSize: 20),
                decoration: InputDecoration(
                    labelText: ' Mail',
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 20,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100),
                    )),
                onChanged: (String value) {
                  email = value;
                },
              ),
              const SizedBox(
                height: 25.0,
              ),
              TextFormField(
                keyboardType: TextInputType.visiblePassword,
                style: const TextStyle(fontSize: 20),
                decoration: InputDecoration(
                    labelText: ' Password',
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 20,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100),
                    )),
                maxLength: 20,
                onChanged: (String value) {
                  password = value;
                },
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
                    'Login',
                    style: TextStyle(fontSize: 18),
                  ),
                  onPressed: () async {
                    try {
                      await auth.signInWithEmailAndPassword(
                        email: email,
                        password: password,
                      );
                      await Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return const RoomSelectPage();
                        }),
                      );
                    } catch (e) {
                      // ユーザー登録に失敗した場合

                      infoText = "登録に失敗しました：${e.toString()}";
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
