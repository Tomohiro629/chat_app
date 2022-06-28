import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final homePageControllerProvider =
    ChangeNotifierProvider<HomePageController>((ref) {
  return HomePageController(ref.read);
});

class HomePageController extends ChangeNotifier {
  final Reader _reader;
  HomePageController(this._reader);
}
