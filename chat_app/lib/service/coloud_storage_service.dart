import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

final storageServiceProvider =
    ChangeNotifierProvider<CloudStorageService>((ref) {
  return CloudStorageService(ref.read);
});

class CloudStorageService extends ChangeNotifier {
  final Reader reader;
  CloudStorageService(this.reader);
  final _storage = FirebaseStorage.instance;
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
    final id = const Uuid().v4();

    final path = id;
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

  // Future<void> deleteStorage(String ref) async {
  //   _storage.ref().delete();
  // }

}
