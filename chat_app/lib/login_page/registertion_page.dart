import 'package:chat_app/login_page/auth_service.dart';
import 'package:chat_app/room_select/room_select_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegistertionPage extends ConsumerWidget {
  RegistertionPage({Key? key}) : super(key: key);

  final FirebaseAuth auth = FirebaseAuth.instance;
  final txetEdit = TextEditingController();
  UserCredential? result;
  User? user;

  String infoText = '';
  String email = '';
  String password = '';
  String authName = '';
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _controller = ref.watch(authServiceProvider);
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text("Registertion Page")),
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
                      horizontal: 10,
                      vertical: 15,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100),
                    )),
                onChanged: (String value) {
                  email = value;
                },
              ),
              const SizedBox(
                height: 25,
              ),
              TextFormField(
                keyboardType: TextInputType.visiblePassword,
                style: const TextStyle(fontSize: 20),
                decoration: InputDecoration(
                    labelText: ' Password',
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 15,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100),
                    )),
                maxLength: 20,
                onChanged: (String value) {
                  if (value.length >= 8) {
                    password = value;
                  } else {
                    print("8文字以上で設定を");
                  }
                },
              ),
              TextFormField(
                controller: txetEdit,
                style: const TextStyle(fontSize: 20),
                decoration: InputDecoration(
                    labelText: ' Name',
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 15,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100),
                    )),
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
                    try {
                      await _controller.addUser(
                          userNameText: txetEdit.text, userId: "");
                    } catch (e) {
                      const Text('error');
                    }

                    try {
                      _controller.createUserWithEmailAndPassword(
                        email,
                        password,
                      );
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RoomSelectPage(
                            chatName: "chatName",
                          ),
                        ),
                      );
                    } catch (e) {
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
