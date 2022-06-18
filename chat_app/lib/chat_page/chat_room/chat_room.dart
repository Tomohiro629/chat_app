import 'package:chat_app/chat_page/chat_page_controller.dart';
import 'package:chat_app/entity/message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatRoom extends ConsumerWidget {
  const ChatRoom({
    Key? key,
    required this.chatId,
  }) : super(key: key);
  final String chatId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _controller = ref.watch(chatControllerProvider);
    final textEdit = TextEditingController();

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Chat Room"),
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
                    child: StreamBuilder<List<Message>>(
                  stream: _controller.fetchMessagesStream(chatId),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Message>> snapshot) {
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
                          children: snapshot.data!.map((Message message) {
                            return ListTile(
                              tileColor: Color.fromARGB(255, 199, 240, 201),
                              title: Text(message.message),
                              subtitle: Text(message.sendTime),
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
                        try {
                          await _controller.addMesseage(
                            messageText: textEdit.text,
                            chatId: chatId,
                          );
                          textEdit.clear();
                        } catch (e) {
                          const Text("Please enter a ChatRoomName");
                        }
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
