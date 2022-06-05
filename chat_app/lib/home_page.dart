import 'package:chat_app/chat_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              height: 500,
            ),
            SizedBox(
              height: 75.0,
              width: 200.0,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ChatPage(),
                      ));
                },
                child: const Text(
                  "Start",
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
