import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

final storageServiceProvider =
    ChangeNotifierProvider<CloudStorageService>((ref) {
  return CloudStorageService(ref.read);
});

class CloudStorageService extends ChangeNotifier {
  final Reader reader;
  CloudStorageService(this.reader);
  final _storage = FirebaseStorage.instance;
  final _picker = ImagePicker();
  File? imagePath;
  String? imageURL;

  Future<String> uploadPostImageAndGetUrl({
    required File file,
  }) async {
    final task = await await _uploadFile(file: file);
    return imageURL = await _getUrl(task!.ref);
  }

  Future<UploadTask?> _uploadFile({
    required File file,
  }) async {
    UploadTask uploadTask;

    const path = "Storageのパス";
    //fileのダウンロード
    final ref = _storage.ref().child(path);

    //file.pathをURLとするFileを読み込む
    uploadTask = ref.putFile(File(file.path));
    //型を変えるためにvalue
    return Future.value(uploadTask);
  }

  Future<String> _getUrl(Reference ref) async {
    //firestorageから画像のURLを取得

    return await ref.getDownloadURL();
  }

  void takeCamera() async {
    final picekdfile = await _picker.pickImage(source: ImageSource.camera);
    if (picekdfile != null) {
      imagePath = File(picekdfile.path);
    }
  }

  void takeGallery() async {
    final picekdfile = await _picker.pickImage(source: ImageSource.gallery);
    if (picekdfile != null) {
      imagePath = File(picekdfile.path);
    }
  }
}
