import 'package:chat_app/service/auth_service.dart';
import 'package:chat_app/service/user_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SetProfilePage extends ConsumerWidget {
  const SetProfilePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final service = ref.watch(userServiceProvider);
    final nameEdit = TextEditingController();
    final newUserId = ref.watch(authServiceProvider).userId;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Set Profile Page"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              radius: 80,
              backgroundColor: const Color.fromARGB(255, 191, 244, 155),
              foregroundImage: (service.imageURL != null)
                  //imgeFileに値があればURLから画像を取得
                  ? FileImage(service.imageURL!)
                  : null,
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
                    service.takeCamera();
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
                    service.takeGallery();
                  },
                  child: const Icon(Icons.photo),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              width: 300,
              child: TextFormField(
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
            ),
            const Padding(
              padding: EdgeInsets.only(top: 5, bottom: 15),
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
                  'Set',
                  style: TextStyle(fontSize: 18),
                ),
                onPressed: () async {
                  try {
                    service.addUser(
                        userNameText: nameEdit.text,
                        userId: newUserId,
                        imgURL: "");
                  } catch (e) {
                    print(e);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
