import 'package:chat_app/entity/message.dart';
import 'package:chat_app/service/image_gallery_saver.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SavedImageDialog extends ConsumerWidget {
  const SavedImageDialog({
    super.key,
    required this.message,
  });
  final Message message;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final imageSaverController = ref.watch(imageSaverServiceProvider);

    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      title: Image(
        image: NetworkImage(
          message.imageURL!,
        ),
      ),
      actions: <Widget>[
        MaterialButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
          color: const Color.fromARGB(255, 240, 124, 116),
          child: const Text("Save"),
          onPressed: () async {
            try {
              imageSaverController.imageSaver(saverImageURL: message.imageURL!);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Image Saved"),
                  backgroundColor: Colors.blue,
                ),
              );
              Navigator.of(context).pop();
            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Saved Error"),
                  backgroundColor: Colors.red,
                ),
              );
              Navigator.of(context).pop();
            }
          },
        ),
        MaterialButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
          color: const Color.fromARGB(255, 137, 196, 244),
          child: const Text("Back"),
          onPressed: () async {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
