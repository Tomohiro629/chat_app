import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

final imagePickerServiceProvider =
    ChangeNotifierProvider<ImagePickerService>((ref) {
  return ImagePickerService();
});

class ImagePickerService extends ChangeNotifier {
  final _picker = ImagePicker();
  File? imagePath;

  Future<void> takeCamera() async {
    final picekdfile =
        await _picker.pickImage(source: ImageSource.camera, imageQuality: 80);
    if (picekdfile != null) {
      imagePath = File(picekdfile.path);
    }
    notifyListeners();
  }

  Future<void> takeGallery() async {
    final picekdfile =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    if (picekdfile != null) {
      imagePath = File(picekdfile.path);
    }
    notifyListeners();
  }
}
