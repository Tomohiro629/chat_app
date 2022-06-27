import 'package:chat_app/chat_page/chat_room/chat_page_controller.dart';
import 'package:chat_app/entity/chat.dart';
import 'package:chat_app/entity/message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatRoom extends ConsumerWidget {
  const ChatRoom({
    Key? key,
    required this.chat,
  }) : super(key: key);
  final Chat chat;

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
                    stream: _controller.fetchMessagesStream(chat.roomId),
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
                            shrinkWrap: true,
                            children: snapshot.data!.map((Message message) {
                              return Padding(
                                //card間の隙間
                                padding: const EdgeInsets.fromLTRB(90, 5, 5, 5),
                                child: Container(
                                  decoration: const BoxDecoration(
                                    color: Color.fromARGB(255, 185, 235, 187),
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(40),
                                      topLeft: Radius.circular(40),
                                      bottomLeft: Radius.circular(40),
                                    ),
                                    gradient: LinearGradient(
                                      begin: FractionalOffset.topLeft,
                                      end: FractionalOffset.bottomRight,
                                      colors: [
                                        Color.fromARGB(255, 95, 244, 169),
                                        Color.fromARGB(222, 177, 236, 187),
                                      ],
                                      stops: [
                                        0.0,
                                        1.0,
                                      ],
                                    ),
                                  ),
                                  child: Padding(
                                      //card内の隙間
                                      padding:
                                          const EdgeInsets.fromLTRB(0, 3, 0, 0),
                                      child: ListTile(
                                        tileColor: const Color.fromARGB(
                                            255, 199, 240, 201),
                                        title: Text(
                                          message.message,
                                          style: const TextStyle(
                                              height: 1.0, fontSize: 18),
                                        ),
                                        subtitle: Text(
                                          message.sendTime,
                                          style: const TextStyle(
                                              height: 1.0,
                                              fontSize: 13,
                                              color: Color.fromARGB(
                                                  233, 255, 255, 255)),
                                        ),
                                        leading: const CircleAvatar(
                                          child: Icon(Icons.face),
                                        ),
                                        shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
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
                                                          BorderRadius.circular(
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
                                                                .circular(100),
                                                      ),
                                                      color:
                                                          const Color.fromARGB(
                                                              255,
                                                              240,
                                                              124,
                                                              116),
                                                      child: const Text("Yes"),
                                                      onPressed: () async {
                                                        await _controller
                                                            .deleteMesseage(
                                                                message:
                                                                    message);
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                    ),
                                                    MaterialButton(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(100),
                                                      ),
                                                      color:
                                                          const Color.fromARGB(
                                                              255,
                                                              137,
                                                              196,
                                                              244),
                                                      child: const Text("No"),
                                                      onPressed: () async {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                    ),
                                                  ],
                                                );
                                              });
                                        },
                                      )),
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
                            chatId: chat.roomId,
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
