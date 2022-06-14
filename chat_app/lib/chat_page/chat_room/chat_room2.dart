import 'package:chat_app/chat_page/chat_page_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatRoom2 extends ConsumerWidget {
  const ChatRoom2({Key? key, required}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _controller = ref.watch(chatControllerProvider);
    final textEdit = TextEditingController();
    List<DocumentSnapshot> docList = [];

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Chat Room2"),
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
                      .doc("room2")
                      .collection("messeages")
                      // .orderBy('sendtime', descending: true)
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
                              tileColor: Color.fromARGB(255, 165, 236, 167),
                              title: Text(document.get('messeage')),
                              subtitle: Text(document.get('sendTime')),
                              leading: ConstrainedBox(
                                constraints: const BoxConstraints(
                                    minHeight: 44,
                                    minWidth: 34,
                                    maxHeight: 64,
                                    maxWidth: 54),
                              ),
                              shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(100)),
                              ),
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
                        await _controller.addMesseage2(messeages);
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
