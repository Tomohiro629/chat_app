import 'package:chat_app/chat_page/chat_page_controller.dart';
import 'package:chat_app/entity/chat.dart';

import 'package:chat_app/entity/loading_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatPage extends ConsumerWidget {
  const ChatPage({Key? key, required}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _controller = ref.watch(chatControllerProvider);
    final messegetime = DateTime.now().toString();
    final textedit = TextEditingController();

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Chat Page"),
        ),
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            ListView.builder(
                itemCount: textedit.text.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    shape: const RoundedRectangleBorder(
                        side: BorderSide(color: Colors.green)),
                    title: Text(textedit.text),
                    subtitle: Text(messegetime),
                    onLongPress: _controller.deleteMesseage(),
                  );
                }),
            Align(
              alignment: Alignment.bottomCenter,
              child: TextField(
                controller: textedit,
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 23.0, horizontal: 8.0),
                    border: const OutlineInputBorder(),
                    labelText: "Text Form",
                    labelStyle: const TextStyle(fontSize: 20),
                    focusColor: Colors.green,
                    suffixIcon: IconButton(
                        onPressed: () async {
                          final messeage = textedit.text;
                          _controller.onPressLoading();
                          await Future.delayed(
                              const Duration(milliseconds: 1500), () {});
                          _controller.addMesseage(messeage);
                        },
                        icon: const Icon(Icons.send))),
                style: const TextStyle(fontSize: 20.0),
              ),
            ),
            LoadingPage(loading: _controller.loading),
          ],
        ));
  }
}
