import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

final imagePickerServiceProvider = Provider<ImagePickerService>((ref) {
  return ImagePickerService();
});

class ImagePickerService {
  final _picker = ImagePicker();
  File? imagePath;

  void takeCamera() async {
    final picekdfile =
        await _picker.pickImage(source: ImageSource.camera, imageQuality: 100);
    if (picekdfile != null) {
      imagePath = File(picekdfile.path);
    }
  }

  void takeGallery() async {
    final picekdfile =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 100);
    if (picekdfile != null) {
      imagePath = File(picekdfile.path);
    }
  }
}
