import 'package:chat_app/base_app_bar.dart';
import 'package:chat_app/my_profile/edit_name_lits_tile.dart';
import 'package:chat_app/repository/user_repository.dart';
import 'package:chat_app/service/image_picker_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyProfilePage extends ConsumerWidget {
  const MyProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final imagePickerService = ref.watch(imagePickerServiceProvider);
    final userController = ref.watch(userRepositoryProvider);

    return Scaffold(
      appBar: const BaseAppBar(
        title: Text("My Profile Page"),
        widgets: [],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const SizedBox(
              height: 80,
            ),
            const CircleAvatar(
              radius: 80,
              backgroundColor: Color.fromARGB(255, 191, 244, 155),
              child: Text("Add Photo"),
            ),
            const SizedBox(
              height: 20,
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
            const SizedBox(
              height: 60,
            ),
            SizedBox(
                width: 370,
                child: Column(
                  children: const <Widget>[
                    EditNameListTile(),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
