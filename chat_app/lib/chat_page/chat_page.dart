import 'package:chat_app/chat_page/chat_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatPage extends ConsumerWidget {
  const ChatPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _controller = ref.watch(chatControllerProvider);
    final messegetime = DateTime.now().toString();
    final textedit = TextEditingController();
    final messeage = textedit.text;

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Chat Page"),
        ),
        body: Center(
            child: Column(
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                  itemCount: messeage.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      shape: const RoundedRectangleBorder(
                          side: BorderSide(color: Colors.green)),
                      title: Text(messeage),
                      subtitle: Text(messegetime),
                      onLongPress: _controller.deleteMesseage(),
                    );
                  }),
            ),
            TextField(
              controller: textedit,
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 23.0, horizontal: 8.0),
                  border: const OutlineInputBorder(),
                  labelText: "Text Form",
                  labelStyle: const TextStyle(fontSize: 20),
                  focusColor: Colors.green,
                  suffixIcon: IconButton(
                      onPressed: () {
                        _controller.addMesseage(messeage);
                      },
                      icon: const Icon(Icons.send))),
              style: const TextStyle(fontSize: 20.0),
            ),
          ],
        )));
  }
}
