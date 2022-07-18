import 'package:chat_app/room_select/room_select_controller.dart';
import 'package:chat_app/service/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddChatRoomPage extends ConsumerWidget {
  const AddChatRoomPage(
      {Key? key, required this.chatId, required this.chatName})
      : super(key: key);
  final String chatId;
  final String chatName;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _controller = ref.watch(roomSelectControllerProvider);
    final chatName = TextEditingController();
    final userId = ref.watch(authServiceProvider).userId;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Add Chat Room"),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.fromLTRB(5, 0, 5, 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                controller: chatName,
                style: const TextStyle(fontSize: 20),
                decoration: InputDecoration(
                    labelText: 'Chat Room Name',
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 15,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100),
                    )),
              ),
              const SizedBox(
                height: 50.0,
                width: 150.0,
              ),
              SizedBox(
                height: 50.0,
                width: 150.0,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                    child: const Text(
                      'Add',
                      style: TextStyle(fontSize: 18),
                    ),
                    onPressed: () async {
                      await _controller.addChatRoom(
                          chatName: chatName.text, userId: userId);
                      Navigator.pop(
                        context,
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
