import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

final imageSaverServiceProvider =
    ChangeNotifierProvider<ImageSaverService>((ref) {
  return ImageSaverService();
});

class ImageSaverService extends ChangeNotifier {
  Future<void> imageSaver({required String saverImageURL}) async {
    //String型のimageURLを端末に保存できる型に変更し保存
    final imageURL = await Dio()
        .get(saverImageURL, options: Options(responseType: ResponseType.bytes));
    await ImageGallerySaver.saveImage(Uint8List.fromList(imageURL.data),
        name: "messageImages");
  }
}
