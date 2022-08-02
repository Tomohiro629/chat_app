import 'package:chat_app/chat_page/chat_page_controller.dart';
import 'package:chat_app/entity/message.dart';
import 'package:chat_app/service/common_method.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_4.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MessageListTile extends ConsumerWidget {
  final Message message;

  const MessageListTile({super.key, required this.message});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(chatControllerProvider);
    return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 35.0),
                    child: Text(
                      getDateString(message.timeStamp),
                      style: const TextStyle(fontSize: 10),
                    ),
                  ),
                  ChatBubble(
                    clipper: ChatBubbleClipper4(type: BubbleType.sendBubble),
                    margin: const EdgeInsets.all(3),
                    padding: const EdgeInsets.fromLTRB(10, 0, 15, 0),
                    backGroundColor: const Color.fromARGB(255, 126, 246, 184),
                    child: Container(
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.5,
                      ),
                      child: TextButton(
                        child: Text(
                          message.message,
                          style: const TextStyle(
                              color: Colors.black, fontSize: 18),
                        ),
                        onLongPress: () {
                          showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (childContext) {
                                return AlertDialog(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50)),
                                  title: Text(
                                      "Delete message\n『${message.message}』"),
                                  content:
                                      const Text("Do you want to Delete it?"),
                                  actions: <Widget>[
                                    MaterialButton(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                      ),
                                      color: const Color.fromARGB(
                                          255, 240, 124, 116),
                                      child: const Text("Yes"),
                                      onPressed: () async {
                                        controller.deleteMessage(
                                            message: message);
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    MaterialButton(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                      ),
                                      color: const Color.fromARGB(
                                          255, 137, 196, 244),
                                      child: const Text("No"),
                                      onPressed: () async {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              });
                        },
                        onPressed: () {},
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ]);
  }
}
