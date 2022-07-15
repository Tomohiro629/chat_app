import 'package:chat_app/chat_page/chat_room/chat_page_controller.dart';
import 'package:chat_app/entity/chat.dart';
import 'package:chat_app/entity/message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CurrentChatRoom extends ConsumerWidget {
  const CurrentChatRoom({
    Key? key,
    required this.chat,
    required this.userId,
  }) : super(key: key);
  final Chat chat;
  final String userId;

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
                    stream:
                        _controller.fetchMessagesStream(chat.roomId, userId),
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
                                backgroundColor:
                                    Color.fromARGB(255, 48, 185, 53),
                              ),
                            ]),
                          );
                        default:
                          return ListView(
                            reverse: true,
                            shrinkWrap: true,
                            children: snapshot.data!.map((Message message) {
                              return Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: <Widget>[
                                        Column(
                                          children: <Widget>[
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                vertical: 0,
                                                horizontal: 10,
                                              ),
                                              constraints: BoxConstraints(
                                                maxWidth: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.5,
                                              ),
                                              decoration: const BoxDecoration(
                                                color: Color.fromARGB(
                                                    255, 167, 254, 170),
                                                borderRadius: BorderRadius.only(
                                                  topRight: Radius.circular(30),
                                                  topLeft: Radius.circular(30),
                                                  bottomLeft:
                                                      Radius.circular(30),
                                                ),
                                              ),
                                              child: ListTile(
                                                tileColor: const Color.fromARGB(
                                                    255, 199, 240, 201),
                                                title: Text(
                                                  message.message,
                                                  style: const TextStyle(
                                                      height: 1.0,
                                                      fontSize: 15),
                                                ),
                                                shape:
                                                    const RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(100)),
                                                ),
                                                onLongPress: () {
                                                  showDialog(
                                                      barrierDismissible: false,
                                                      context: context,
                                                      builder: (childContext) {
                                                        return AlertDialog(
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          50)),
                                                          title: Text(
                                                              "Delete message\n『${message.message}』"),
                                                          content: const Text(
                                                              "Do you want to Delete it?"),
                                                          actions: <Widget>[
                                                            MaterialButton(
                                                              shape:
                                                                  RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            100),
                                                              ),
                                                              color: const Color
                                                                      .fromARGB(
                                                                  255,
                                                                  240,
                                                                  124,
                                                                  116),
                                                              child: const Text(
                                                                  "Yes"),
                                                              onPressed:
                                                                  () async {
                                                                _controller
                                                                    .deleteMesseage(
                                                                        message:
                                                                            message);
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                              },
                                                            ),
                                                            MaterialButton(
                                                              shape:
                                                                  RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            100),
                                                              ),
                                                              color: const Color
                                                                      .fromARGB(
                                                                  255,
                                                                  137,
                                                                  196,
                                                                  244),
                                                              child: const Text(
                                                                  "No"),
                                                              onPressed:
                                                                  () async {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                              },
                                                            ),
                                                          ],
                                                        );
                                                      });
                                                },
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              message.sendTime,
                                              style:
                                                  const TextStyle(fontSize: 10),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                    Column(children: const <Widget>[
                                      SizedBox(
                                        height: 45,
                                      ),
                                      CircleAvatar(
                                        backgroundColor:
                                            Color.fromARGB(255, 160, 212, 255),
                                      ),
                                    ])
                                  ],
                                ),
                              );
                            }).toList(),
                          );
                      }
                    },
                  ),
                ),
                TextField(
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  controller: textEdit,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 5.0, horizontal: 10.0),
                    border: const OutlineInputBorder(),
                    labelText: "Text Form",
                    labelStyle: const TextStyle(fontSize: 20),
                    focusColor: Colors.green,
                    suffixIcon: IconButton(
                      onPressed: () async {
                        try {
                          await _controller.addMesseage(
                            messageText: textEdit.text,
                            chatId: chat.roomId,
                            userId: userId,
                          );
                          textEdit.clear();
                        } catch (e) {
                          const Dialog(
                            child: Text("Please enter a Message"),
                          );
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
