import 'package:chat_app/chat_page/chat_room/chat_room.dart';
import 'package:chat_app/home_page.dart';
import 'package:chat_app/room_select/add_chat_room.dart';
import 'package:chat_app/room_select/room_select_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RoomSelectPage extends ConsumerWidget {
  const RoomSelectPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _controller = ref.watch(roomSelectControllerProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Room Select"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (childContext) {
                    return AlertDialog(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)),
                      title: const Text("Log Out!"),
                      content: const Text("Do you want to logout it?"),
                      actions: <Widget>[
                        MaterialButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100),
                          ),
                          color: Color.fromARGB(255, 240, 124, 116),
                          child: const Text("Yes"),
                          onPressed: () async {
                            await _controller.logOut();
                            await Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) {
                                  return const HomePage();
                                },
                              ),
                            );
                          },
                        ),
                        MaterialButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100),
                          ),
                          color: Color.fromARGB(255, 137, 196, 244),
                          child: const Text("No"),
                          onPressed: () async {
                            await Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) {
                                  return const RoomSelectPage();
                                },
                              ),
                            );
                          },
                        ),
                      ],
                    );
                  });
            },
          ),
        ],
      ),
      body: Center(
        child: Card(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(5, 20, 5, 20),
            children: [
              ListTile(
                tileColor: Color.fromARGB(255, 199, 240, 201),
                title: const Text(
                  "Chat Room1",
                  style: TextStyle(fontSize: 20),
                ),
                leading: ConstrainedBox(
                  constraints: const BoxConstraints(
                      minHeight: 44, minWidth: 34, maxHeight: 64, maxWidth: 54),
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.login),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ChatRoom(chatId: 'room1'),
                        ));
                  },
                ),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(100)),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              ListTile(
                tileColor: Color.fromARGB(255, 165, 236, 167),
                title: const Text(
                  "Chat Room2",
                  style: TextStyle(fontSize: 20),
                ),
                leading: ConstrainedBox(
                  constraints: const BoxConstraints(
                      minHeight: 44, minWidth: 34, maxHeight: 64, maxWidth: 54),
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.login),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ChatRoom(chatId: 'room1'),
                        ));
                  },
                ),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(100)),
                ),
                onLongPress: () {
                  // _controller.deleteRoom(chatId: "chatId");
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddChatRoomPage()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
