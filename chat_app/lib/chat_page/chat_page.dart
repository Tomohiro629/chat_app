import 'package:chat_app/base_app_bar.dart';
import 'package:chat_app/chat_page/chat_page_controller.dart';
import 'package:chat_app/chat_page/message_list_tile.dart';
import 'package:chat_app/entity/chat_room.dart';
import 'package:chat_app/entity/message.dart';
import 'package:chat_app/service/coloud_storage_service.dart';
import 'package:chat_app/setting_page/setting_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterfire_ui/firestore.dart';

class ChatPage extends ConsumerWidget {
  const ChatPage({
    Key? key,
    required this.chat,
  }) : super(key: key);
  final ChatRoom chat;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(chatControllerProvider);
    final textEdit = TextEditingController();

    return Scaffold(
      appBar: BaseAppBar(
        title: const Text("Chat Room"),
        widgets: [
          CircleAvatar(
            backgroundImage:
                NetworkImage(ref.watch(storageServiceProvider).imageURL!),
          ),
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
        children: [
          Container(
            padding: const EdgeInsets.only(bottom: 50),
            child: FirestoreListView<Message>(
                reverse: true,
                query: controller.messageQuery(chatId: chat.roomId),
                itemBuilder: (context, snapshot) {
                  final message = snapshot.data();
                  // ref.watch(authServiceProvider).userId == userIds ?
                  return MessageListTile(
                    message: message,
                  );
                  // : PartnerMessageListTile(message: message);
                }),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: TextFormField(
              keyboardType: TextInputType.multiline,
              maxLines: null,
              controller: textEdit,
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                border: const OutlineInputBorder(),
                labelText: "Text Form",
                labelStyle: const TextStyle(fontSize: 20),
                focusColor: Colors.green,
                suffixIcon: IconButton(
                  onPressed: () async {
                    try {
                      await controller.addMesseage(
                        messageText: textEdit.text,
                        chatId: chat.roomId,
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
          ),
        ],
      ),
    );
  }
}