import 'package:chat_app/chat_page/chat_room/chat_room.dart';
import 'package:chat_app/entity/chat.dart';
import 'package:chat_app/home_page.dart';
import 'package:chat_app/room_select/add_chat_room.dart';
import 'package:chat_app/room_select/room_select_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RoomSelectPage extends ConsumerWidget {
  const RoomSelectPage({Key? key, required this.chatName}) : super(key: key);
  final String chatName;
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
                                  return const RoomSelectPage(
                                    chatName: "chatName",
                                  );
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
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Column(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
              ),
              Expanded(
                child: StreamBuilder<List<Chat>>(
                  stream: _controller.fetchChatRoomStream(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Chat>> snapshot) {
                    if (snapshot.hasError) {
                      return Text("Error:${snapshot.error}");
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
                            children: snapshot.data!.map((Chat chat) {
                              return ListTile(
                                tileColor: Color.fromARGB(255, 199, 240, 201),
                                title: Text(
                                  chat.chatName,
                                ),
                                subtitle: Text("作成日${chat.addTime}"),
                                trailing: IconButton(
                                  icon: const Icon(Icons.login),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => ChatRoom(
                                            chat: chat,
                                          ),
                                        ));
                                  },
                                ),
                                shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(100)),
                                ),
                              );
                            }).toList());
                    }
                  },
                ),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const AddChatRoomPage(
                        chatId: "",
                        chatName: "",
                      )));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
