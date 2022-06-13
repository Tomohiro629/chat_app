import 'package:chat_app/chat_page/chat_page_controller.dart';
import 'package:chat_app/entity/loading_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class ChatPage extends ConsumerWidget {
  const ChatPage({Key? key, required}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _controller = ref.watch(chatControllerProvider);
    final sendTime = DateFormat("yyyy年MM月dd日 hh時mm分").format(DateTime.now());
    final textEdit = TextEditingController();
    List<DocumentSnapshot> docList = [];

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Chat Page"),
        ),
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                ),
                Expanded(
                    child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('chat_rooms')
                      .doc("room1")
                      .collection("messeages")
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    }
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return Center(
                          child: Stack(children: const [
                            CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  Color.fromARGB(255, 6, 121, 11)),
                              backgroundColor: Color.fromARGB(255, 48, 185, 53),
                            ),
                          ]),
                        );
                      default:
                        return ListView(
                          shrinkWrap: true,
                          children: snapshot.data!.docs
                              .map((DocumentSnapshot document) {
                            return ListTile(
                              title: Text(document.get('messeage')),
                              // subtitle: Text(document.get('sendTime')),
                              onLongPress: () {},
                            );
                          }).toList(),
                        );
                    }
                  },
                )),
                TextField(
                  controller: textEdit,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 23.0, horizontal: 8.0),
                    border: const OutlineInputBorder(),
                    labelText: "Text Form",
                    labelStyle: const TextStyle(fontSize: 20),
                    focusColor: Colors.green,
                    suffixIcon: IconButton(
                      onPressed: () async {
                        final messeages = textEdit.text;
                        _controller.onPressLoading();
                        await _controller.addMesseage(messeages);
                        textEdit.clear();
                      },
                      icon: const Icon(Icons.send),
                    ),
                  ),
                  style: const TextStyle(fontSize: 20.0),
                ),
              ],
            ),
          ],
        ));
  }
}
