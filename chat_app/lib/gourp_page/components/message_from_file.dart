import 'package:chat_app/chat_page/chat_page_controller.dart';
import 'package:chat_app/entity/chat_room.dart';
import 'package:chat_app/repository/user_repository.dart';
import 'package:chat_app/service/auth_service.dart';
import 'package:chat_app/service/coloud_storage_service.dart';
import 'package:chat_app/service/image_picker_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MessageFromFile extends ConsumerWidget {
  const MessageFromFile({
    Key? key,
    required this.chat,
    required this.imageURL,
  }) : super(key: key);
  final ChatRoom chat;
  final String imageURL;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(chatControllerProvider);
    final userController = ref.watch(userRepositoryProvider);
    final imagePickerService = ref.watch(imagePickerServiceProvider);

    final storageService = ref.watch(storageServiceProvider);
    final textEdit = TextEditingController();

    return TextFormField(
      keyboardType: TextInputType.multiline,
      maxLines: null,
      controller: textEdit,
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(100),
        ),
        labelStyle: const TextStyle(fontSize: 20),
        focusColor: Colors.green,
        suffixIcon: IconButton(
          onPressed: () async {
            final currentUser = await userController.getUserDate(
                userId: ref.watch(authServiceProvider).userId);
            try {
              textEdit.text.isNotEmpty && imageURL.isNotEmpty
                  ? await controller.addMesseage(
                      messageText: textEdit.text,
                      chatId: chat.roomId,
                      imageURL: imageURL,
                      currentUserImage: currentUser.imageURL)
                  // ignore: use_build_context_synchronously
                  : ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
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
              // ignore: use_build_context_synchronously
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Send message error"),
                backgroundColor: Colors.red,
                duration: Duration(seconds: 1),
              ));
            }
          },
          icon: const Icon(Icons.send),
        ),
      ),
      style: const TextStyle(fontSize: 20.0),
    );
  }
}
