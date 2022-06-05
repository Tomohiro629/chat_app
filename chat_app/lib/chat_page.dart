import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
              ),
            ),
            TextField(
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 23.0, horizontal: 8.0),
                  border: const OutlineInputBorder(),
                  labelText: "Text Form",
                  labelStyle: const TextStyle(fontSize: 20),
                  focusColor: Colors.green,
                  suffixIcon: IconButton(
                      onPressed: () {}, icon: const Icon(Icons.send))),
              style: const TextStyle(fontSize: 20.0),
            ),
          ],
        ),
      ),
    );
  }
}
