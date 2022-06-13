import 'dart:ffi';

import 'package:chat_app/chat_page/chat_page.dart';
import 'package:chat_app/chat_page/test_chat.dart';
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
              height: 400,
            ),
            SizedBox(
              height: 50.0,
              width: 150.0,
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
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 50.0,
              width: 150.0,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TestChat(),
                      ));
                },
                child: const Text(
                  "Test",
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
