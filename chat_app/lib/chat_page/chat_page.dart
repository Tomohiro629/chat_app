import 'package:chat_app/base_app_bar.dart';
import 'package:chat_app/chat_page/chat_page_controller.dart';
import 'package:chat_app/chat_page/components/message_from_file.dart';
import 'package:chat_app/chat_page/components/message_list_tile.dart';
import 'package:chat_app/chat_page/components/partner_message_list_tile.dart';
import 'package:chat_app/chat_page/components/send_image_dialog.dart';
import 'package:chat_app/entity/chat_room.dart';
import 'package:chat_app/entity/message.dart';
import 'package:chat_app/service/auth_service.dart';
import 'package:chat_app/service/image_picker_service.dart';
import 'package:chat_app/setting_page/setting_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterfire_ui/firestore.dart';

class ChatPage extends ConsumerWidget {
  const ChatPage({
    Key? key,
    required this.chat,
    required this.imageURL,
    required this.roomName,
  }) : super(key: key);
  final ChatRoom chat;
  final String imageURL;
  final String roomName;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(chatControllerProvider);
    final imagePickerService = ref.watch(imagePickerServiceProvider);

    return Scaffold(
      appBar: BaseAppBar(
        title: Text(roomName),
        widgets: [
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
        children: [
          Container(
            padding: const EdgeInsets.only(bottom: 50.0),
            child: FirestoreListView<Message>(
                reverse: true,
                query: controller.messageQuery(chatId: chat.roomId),
                itemBuilder: (context, snapshot) {
                  final message = snapshot.data();
                  return ref.watch(authServiceProvider).userId == message.userId
                      ? MessageListTile(
                          message: message,
                        )
                      : PartnerMessageListTile(
                          message: message,
                          userImageURL: imageURL,
                          roomName: roomName,
                        );
                }),
          ),
          Stack(
            children: [
              Center(
                child: imagePickerService.imagePath != null
                    ? SendImageDialog(
                        chat: chat,
                      )
                    : const Text(""),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.camera_alt,
                    color: Color.fromARGB(255, 255, 168, 7),
                  ),
                  onPressed: () {
                    imagePickerService.takeCamera();
                  },
                ),
                IconButton(
                  icon: const Icon(
                    Icons.photo,
                    color: Color.fromARGB(255, 255, 168, 7),
                  ),
                  onPressed: () {
                    imagePickerService.takeGallery();
                  },
                ),
                SizedBox(
                  width: 300.0,
                  child: MessageFromFile(
                    chat: chat,
                    imageURL: imageURL,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
