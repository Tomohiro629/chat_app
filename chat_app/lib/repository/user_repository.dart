import 'dart:io';

import 'package:chat_app/entity/chat_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

final userRepositoryProvider = Provider(((ref) {
  return UserRepository();
}));

class UserRepository {
  final _firestore = FirebaseFirestore.instance;
  File? imageURL;
  final picker = ImagePicker();
  String? imgURL;

  Future<void> setUser({
    required ChatUser user,
  }) async {
    if (imageURL != null) {
      try {
        final task = await FirebaseStorage.instance
            .ref('user_photo/${user.userId}')
            .putFile(imageURL!);
        imgURL = await task.ref.getDownloadURL();
        await _firestore
            .collection("users")
            .doc(user.userId)
            .set(user.toJson(), SetOptions(merge: true));
      } catch (e) {
        print(e);
      }
    }
  }

  Future<void> deleteUser(String userId) async {
    await _firestore.collection("users").doc(userId).delete();
  }

  Stream<ChatUser?> fetchUserStream(String userId) {
    final snapshots = _firestore.collection('users').doc(userId).snapshots();

    return snapshots.map(
        ((doc) => doc.data() == null ? null : ChatUser.fromJson(doc.data()!)));
  }

  Stream<List<ChatUser>> fetchUsersStream() {
    final snapshots = _firestore.collection('users').snapshots();

    return snapshots.map(
        (qs) => qs.docs.map((doc) => ChatUser.fromJson(doc.data())).toList());
  }

  void takeCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      imageURL = File(pickedFile.path);
    }
  }

  void takeGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      imageURL = File(pickedFile.path);
    }
  }
}
