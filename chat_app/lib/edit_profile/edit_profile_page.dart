import 'package:chat_app/base_app_bar.dart';
import 'package:chat_app/service/auth_service.dart';
import 'package:chat_app/service/image_picker_service.dart';
import 'package:chat_app/service/user_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EditProfilePage extends ConsumerWidget {
  const EditProfilePage({
    Key? key,
    required this.imageURL,
    required this.userName,
  }) : super(key: key);
  final String imageURL;
  final String userName;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userService = ref.watch(userServiceProvider);
    final imagePickerService = ref.watch(imagePickerServiceProvider);
    final userId = ref.watch(authServiceProvider).userId;
    final editName = TextEditingController();
    editName.text = userName;

    return Scaffold(
      appBar: const BaseAppBar(
        title: Text("Edit Profile"),
        widgets: [],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            CircleAvatar(
              radius: 80,
              backgroundColor: const Color.fromARGB(255, 191, 244, 155),
              foregroundImage: NetworkImage(imageURL),
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
                    imagePickerService.takeCamera();
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
                    imagePickerService.takeGallery();
                  },
                  child: const Icon(Icons.photo),
                ),
              ],
            ),
            SizedBox(
              height: 50.0,
              width: 300.0,
              child: SizedBox(
                width: 300.0,
                child: TextFormField(
                  style: const TextStyle(fontSize: 20),
                  maxLines: 1,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    labelText: "UserName",
                    labelStyle: const TextStyle(fontSize: 20),
                    focusColor: Colors.green,
                  ),
                  controller: editName,
                ),
              ),
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
                  'Edit',
                  style: TextStyle(fontSize: 18),
                ),
                onPressed: () async {
                  try {
                    userService.addUser(
                      userNameText: editName.text,
                      userId: userId,
                      imageURL: imageURL,
                    );
                    Navigator.pop(context);
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
