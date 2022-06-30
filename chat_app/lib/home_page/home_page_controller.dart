import 'package:chat_app/room_select/room_select_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final homePageControllerProvider =
    ChangeNotifierProvider<HomePageController>((ref) {
  return HomePageController(ref.read);
});

class HomePageController extends ChangeNotifier {
  final Reader _reader;
  HomePageController(this._reader);
  final loginName = "A";
  final authName = "B";

  Future<void> getDate(String userName, String chatName) async {
    if (loginName == authName) {
      _reader(roomSelectControllerProvider).fetchChatRoomStream();
      print("成功");
    } else {
      print("error");
    }
  }
}
