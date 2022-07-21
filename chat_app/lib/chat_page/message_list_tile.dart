import 'package:chat_app/entity/message.dart';
import 'package:flutter/material.dart';

class MessageListTile extends StatelessWidget {
  final Message message;

  const MessageListTile({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Column(
                children: <Widget>[
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 0,
                      horizontal: 10,
                    ),
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.5,
                    ),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 167, 254, 170),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: ListTile(
                      tileColor: const Color.fromARGB(255, 199, 240, 201),
                      title: Text(
                        message.message,
                        style: const TextStyle(height: 1.0, fontSize: 15),
                      ),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(100)),
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
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                    color: const Color.fromARGB(
                                        255, 240, 124, 116),
                                    child: const Text("Yes"),
                                    onPressed: () async {
                                      // _controller.deleteMesseage(
                                      //     message: message);
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  MaterialButton(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(100),
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
                    ),
                  ),
                  Text(
                    message.sendTime,
                    style: const TextStyle(fontSize: 10),
                  )
                ],
              ),
            ],
          ),
        ]);
  }
}
