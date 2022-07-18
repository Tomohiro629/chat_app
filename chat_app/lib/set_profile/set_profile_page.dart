import 'dart:io';

import 'package:chat_app/service/auth_service.dart';
import 'package:chat_app/service/coloud_storage_service.dart';
import 'package:chat_app/service/user_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class SetProfilePage extends ConsumerWidget {
  const SetProfilePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final service = ref.watch(userServiceProvider);
    final image = ref.watch(storageServiceProvider);
    final nameEdit = TextEditingController();
    final newUserId = ref.watch(authServiceProvider).userId;
    final picker = ImagePicker();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Set Profile Page"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            const CircleAvatar(
              radius: 80,
              backgroundColor: Color.fromARGB(255, 191, 244, 155),
              child: Text("Add Photo"),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                  onPressed: () {
                    image.takeCamera();
                  },
                  child: const Icon(Icons.camera_alt),
                ),
                const SizedBox(
                  width: 40,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                  onPressed: () {
                    image.takeGallery();
                  },
                  child: const Icon(Icons.photo),
                ),
              ],
            ),
            SizedBox(
                height: 60,
                width: 300,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      controller: nameEdit,
                      style: const TextStyle(fontSize: 20),
                      decoration: InputDecoration(
                          labelText: 'Name',
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 15,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100),
                          )),
                    ),
                  ],
                )),
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
                  'Set',
                  style: TextStyle(fontSize: 18),
                ),
                onPressed: () async {
                  try {
                    image.uploadPostImageAndGetUrl(file: image.imagePath!);
                    service.addUser(
                      userNameText: nameEdit.text,
                      userId: newUserId,
                      imageURL: image.imageURL!,
                    );
                  } catch (e) {
                    print(e);
                  }
                },
              ),
            ),
            const SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }
}
