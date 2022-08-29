import 'package:chat_app/chat_page/chat_page_controller.dart';
import 'package:chat_app/entity/chat_room.dart';
import 'package:chat_app/service/coloud_storage_service.dart';
import 'package:chat_app/service/image_picker_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SendImageDialog extends ConsumerWidget {
  const SendImageDialog({
    super.key,
    required this.chat,
  });
  final ChatRoom chat;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(chatControllerProvider);
    final storageService = ref.watch(storageServiceProvider);
    final imagePickerService = ref.watch(imagePickerServiceProvider);

    return AlertDialog(
      content: Stack(
        alignment: Alignment.center,
        children: [
          ConstrainedBox(
            constraints:
                const BoxConstraints(maxHeight: 400.0, maxWidth: 200.0),
            child: Image(
              image: FileImage(imagePickerService.imagePath!),
            ),
          ),
        ],
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      title: const Text(
        "Send This Image",
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: const Color.fromARGB(131, 76, 175, 79),
      actions: <Widget>[
        MaterialButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
          color: const Color.fromARGB(255, 240, 124, 116),
          child: const Text("Send"),
          onPressed: () async {
            try {
              await storageService.uploadPostImageAndGetUrl(
                  file: imagePickerService.imagePath!);
              await controller.addMesseage(
                  messageText: "Send a photo",
                  chatId: chat.roomId,
                  imageURL: storageService.imageURL!,
                  currentUserImage: "");
              await controller.addLastMessage(
                  chatId: chat.roomId, lastMessage: "Send a photo");
              imagePickerService.imagePath = null;
            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Send error"),
                backgroundColor: Colors.red,
                duration: Duration(seconds: 1),
              ));
            }
          },
        ),
      ],
    );
  }
}
