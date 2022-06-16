import 'package:chat_app/login_page/login_page.dart';
import 'package:chat_app/login_page/registertion_page.dart';
import 'package:chat_app/room_select/room_select_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Home Page"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const SizedBox(
              height: 200,
            ),
            const Text(
              'Chat App',
              style: TextStyle(color: Colors.green, fontSize: 45),
            ),
            const SizedBox(
              height: 200,
              //height:400
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RoomSelectPage(),
                      ));
                },
                child: const Text("チャットへ")),
            const SizedBox(
              height: 150,
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
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginPage(),
                      ));
                },
                child: const Text(
                  "Login",
                  style: TextStyle(fontSize: 18.0),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RegistertionPage(),
                    ));
              },
              child: const Text("Sign Up"),
            )
          ],
        ),
      ),
    );
  }
}
