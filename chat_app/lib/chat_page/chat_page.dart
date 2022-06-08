import 'package:chat_app/chat_page/chat_page_controller.dart';
import 'package:chat_app/entity/chat.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatPage extends ConsumerWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _controller = ref.watch(chatControllerProvider);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Chat Page"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
              ),
            ),
            TextField(
              onChanged: (text) {
                _controller.newMesseage(text);
              },
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 23.0, horizontal: 8.0),
                  border: const OutlineInputBorder(),
                  labelText: "Text Form",
                  labelStyle: const TextStyle(fontSize: 20),
                  focusColor: Colors.green,
                  suffixIcon: IconButton(
                      onPressed: () {
                        _controller.addMesseage();
                      },
                      icon: const Icon(Icons.send))),
              style: const TextStyle(fontSize: 20.0),
            ),
          ],
        ),
      ),
    );
  }
}
