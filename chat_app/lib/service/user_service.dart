import 'dart:io';

import 'package:chat_app/entity/chat_user.dart';
import 'package:chat_app/repository/user_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

final userServiceProvider = ChangeNotifierProvider<UserService>((ref) {
  return UserService(ref.read);
});

class UserService extends ChangeNotifier {
  final Reader _reader;
  final picker = ImagePicker();
  UserService(this._reader);

  Future<void> addUser({
    required String userNameText,
    required String userId,
    required String imgURL,
  }) async {
    final user = ChatUser.create(
        userNameText: userNameText, userId: userId, imgURL: imgURL);
    await _reader(userRepositoryProvider).setUser(user: user);
  }

  Stream<ChatUser?> fetchUserStream(String userId) {
    return _reader(userRepositoryProvider).fetchUserStream(userId);
  }

  Stream<List<ChatUser>> fetchUsersStream(String userId) {
    return _reader(userRepositoryProvider).fetchUsersStream();
  }

  Future<void> deleteUser(String userId) async {
    await _reader(userRepositoryProvider).deleteUser(userId);
  }

  File? imageFile;

  void takeCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
    }

    notifyListeners;
  }

  void takeGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
    }

    notifyListeners;
  }
}
