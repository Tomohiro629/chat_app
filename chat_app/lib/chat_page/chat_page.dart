import 'package:chat_app/base_app_bar.dart';
import 'package:chat_app/chat_page/chat_page_controller.dart';
import 'package:chat_app/chat_page/components/message_list_tile.dart';
import 'package:chat_app/chat_page/components/partner_message_list_tile.dart';
import 'package:chat_app/chat_page/components/send_image_dailog.dart';
import 'package:chat_app/entity/chat_room.dart';
import 'package:chat_app/entity/message.dart';
import 'package:chat_app/entity/send_image.dart';
import 'package:chat_app/repository/send_image_repository.dart';
import 'package:chat_app/service/auth_service.dart';
import 'package:chat_app/service/coloud_storage_service.dart';
import 'package:chat_app/service/image_picker_service.dart';
import 'package:chat_app/setting_page/setting_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterfire_ui/firestore.dart';

class ChatPage extends ConsumerWidget {
  const ChatPage({
    Key? key,
    required this.chat,
    required this.userImageURL,
    required this.roomName,
  }) : super(key: key);
  final ChatRoom chat;
  final String userImageURL;
  final String roomName;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(chatControllerProvider);
    final imagePickerService = ref.watch(imagePickerServiceProvider);
    final storageService = ref.watch(storageServiceProvider);
    final textEdit = TextEditingController();

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
            child: FirestoreListView<SendImage>(
                reverse: true,
                query: controller.imageQuery(chatId: chat.roomId),
                itemBuilder: (context, snapshot) {
                  final image = snapshot.data();
                  return Image(
                    image: NetworkImage(image.imageURL!),
                    width: 10.0,
                    height: 200.0,
                  );
                }),
          ),
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
                          userImageURL: userImageURL,
                        );
                }),
          ),
          Stack(
            children: [
              Center(
                child: imagePickerService.imagePath != null
                    ? SendImageDailog(
                        chat: chat,
                      )
                    : const Text(""),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Row(
              children: [
                IconButton(
                    onPressed: () {
                      imagePickerService.takeCamera();
                    },
                    icon: const Icon(
                      Icons.camera_alt,
                      color: Color.fromARGB(255, 255, 168, 7),
                    )),
                IconButton(
                    onPressed: () {
                      imagePickerService.takeGallery();
                    },
                    icon: const Icon(
                      Icons.photo,
                      color: Color.fromARGB(255, 255, 168, 7),
                    )),
                SizedBox(
                  width: 300.0,
                  child: TextFormField(
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    controller: textEdit,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 5.0, horizontal: 10.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                      labelStyle: const TextStyle(fontSize: 20),
                      focusColor: Colors.green,
                      suffixIcon: IconButton(
                        onPressed: () async {
                          try {
                            textEdit.text.isNotEmpty
                                ? await controller.addMesseage(
                                    messageText: textEdit.text,
                                    chatId: chat.roomId,
                                  )
                                : ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                    content: Text("Please enter your message"),
                                    backgroundColor: Colors.red,
                                  ));

                            await controller.addLastMessage(
                              chatId: chat.roomId,
                              lastMessage: textEdit.text,
                            );
                            await storageService.uploadPostImageAndGetUrl(
                                file: imagePickerService.imagePath!);
                            textEdit.clear();
                          } catch (e) {
                            print(e);
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
          ),
        ],
      ),
    );
  }
}
