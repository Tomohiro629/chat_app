import 'package:chat_app/room_select/room_select_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegistertionPage extends StatelessWidget {
  RegistertionPage({Key? key}) : super(key: key);

  final FirebaseAuth auth = FirebaseAuth.instance;
  final _editingController = TextEditingController();
  UserCredential? result;
  User? user;

  String infoText = '';
  String email = '';
  String password = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text("Registertion Page")),
      body: Center(
        child: Container(
          padding: const EdgeInsets.fromLTRB(5, 0, 5, 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                controller: _editingController,
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
                  // _editingController.selection = TextSelection.fromPosition(
                  //   const TextPosition(offset: 30),
                  // );
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
                      vertical: 20,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100),
                    )),
                maxLength: 20,
                onChanged: (String value) {
                  if (value.length >= 8) {
                    password = value;
                  } else {}
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
                    'Sign Up',
                    style: TextStyle(fontSize: 18),
                  ),
                  onPressed: () async {
                    try {
                      await auth.createUserWithEmailAndPassword(
                        email: email,
                        password: password,
                      );
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RoomSelectPage()),
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