import 'package:chat_app/chat_page/chat_room/chat_room1.dart';
import 'package:chat_app/chat_page/chat_room/chat_room2.dart';
import 'package:flutter/material.dart';

class RoomSelectPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Room Select"),
        centerTitle: true,
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
                trailing: const Icon(Icons.login),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(100)),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ChatRoom1(),
                      ));
                },
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
                trailing: const Icon(Icons.login),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(100)),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ChatRoom2(),
                      ));
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //後々ルーム作成する
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
