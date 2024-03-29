import 'package:chat_app/base_app_bar.dart';
import 'package:chat_app/repository/user_repository.dart';
import 'package:chat_app/service/auth_service.dart';
import 'package:chat_app/service/coloud_storage_service.dart';
import 'package:chat_app/service/image_picker_service.dart';
import 'package:chat_app/service/user_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SetProfilePage extends ConsumerWidget {
  const SetProfilePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userService = ref.watch(userServiceProvider);
    final userRepository = ref.watch(userRepositoryProvider);
    final storageService = ref.watch(storageServiceProvider);
    final imagePickerService = ref.watch(imagePickerServiceProvider);
    final nameEdit = TextEditingController();
    final newUserId = ref.watch(authServiceProvider).userId;

    return Scaffold(
      appBar: const BaseAppBar(
        title: Text("Set Profile"),
        widgets: [],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            CircleAvatar(
              radius: 80,
              foregroundImage: imagePickerService.imagePath != null
                  ? FileImage(
                      imagePickerService.imagePath!,
                    )
                  : null,
              backgroundColor: const Color.fromARGB(255, 191, 244, 155),
              child: const Text("Add Photo"),
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
                    final user =
                        await userRepository.checkUserName(nameEdit.text);
                    storageService.uploadPostImageAndGetUrl(
                        file: imagePickerService.imagePath!);
                    if (user == null) {
                      userService.addUser(
                        userNameText: nameEdit.text,
                        userId: newUserId,
                        imageURL: storageService.imageURL!,
                      );
                    } else {
                      // ignore: use_build_context_synchronously
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Name already registered"),
                        backgroundColor: Colors.red,
                      ));
                    }
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text(
                          "Registration Error. Please Enter The Required Information"),
                      backgroundColor: Colors.red,
                    ));
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
