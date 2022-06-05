import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: const [Text('ChatPage')]),
      body: Center(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
              ),
            ),
            const TextField(
              decoration: InputDecoration(
                hintText: "Enter",
                labelText: "Chat Start",
              ),
            ),
            ElevatedButton(
              onPressed: () {},
              child: const Text("Send"),
            )
          ],
        ),
      ),
    );
  }
}
