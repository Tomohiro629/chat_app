import 'package:chat_app/chat_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: const [Text('HomePage')]),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Chat App',
              style: TextStyle(color: Colors.greenAccent, fontSize: 30),
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChatPage(),
                      ));
                },
                child: const Text("Start"))
          ],
        ),
      ),
    );
  }
}
