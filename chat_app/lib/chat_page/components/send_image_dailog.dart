import 'package:chat_app/chat_page/chat_page_controller.dart';
import 'package:chat_app/entity/chat_room.dart';
import 'package:chat_app/repository/send_image_repository.dart';
import 'package:chat_app/service/auth_service.dart';
import 'package:chat_app/service/coloud_storage_service.dart';
import 'package:chat_app/service/image_picker_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SendImageDailog extends ConsumerWidget {
  const SendImageDailog({
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
          children: [Image(image: FileImage(imagePickerService.imagePath!))]),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      title: const Text(
        "Send This Image?",
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.black38,
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
              await controller.addSendImage(
                  chatId: chat.roomId, imageURL: storageService.imageURL!);
              Navigator.pop(context);
            } catch (e) {
              print(e);
            }
          },
        ),
        MaterialButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
          color: const Color.fromARGB(255, 137, 196, 244),
          child: const Text("No"),
          onPressed: () async {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
