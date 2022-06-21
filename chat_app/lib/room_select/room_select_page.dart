import 'package:chat_app/chat_page/chat_room/chat_room.dart';
import 'package:chat_app/entity/chat.dart';
import 'package:chat_app/home_page.dart';
import 'package:chat_app/room_select/add_chat_room.dart';
import 'package:chat_app/room_select/room_select_controller.dart';
import 'package:chat_app/setting_page/setting_page.dart';
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
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return const SettingPage();
              }));
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
              StreamBuilder<List<Chat>>(
                stream: _controller.fetchChatRoomStream(),
                builder:
                    (BuildContext context, AsyncSnapshot<List<Chat>> snapshot) {
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
                            return Card(
                              color: const Color.fromARGB(255, 199, 240, 201),
                              shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(100)),
                              ),
                              child: ListTile(
                                title: Text(
                                  chat.chatName,
                                ),
                                subtitle: Text("作成日${chat.addTime}"),
                                shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(100)),
                                ),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ChatRoom(
                                          chat: chat,
                                        ),
                                      ));
                                },
                                onLongPress: () {
                                  showDialog(
                                      barrierDismissible: false,
                                      context: context,
                                      builder: (childContext) {
                                        return AlertDialog(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(50)),
                                          title: Text(
                                              "Delete Room\n『${chat.chatName}』"),
                                          content: const Text(
                                              "Do you want to Delete it?"),
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
                                                _controller.deleteChatRoom(
                                                    chat: chat);
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
                              ),
                            );
                          }).toList());
                  }
                },
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
