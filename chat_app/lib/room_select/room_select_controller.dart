import 'package:chat_app/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final roomSelectControllerProvider =
    ChangeNotifierProvider<RoomSelectController>((ref) {
  return RoomSelectController();
});

class RoomSelectController extends ChangeNotifier {
  final auth = FirebaseAuth.instance;
  Future<void> logOut() async {
    await auth.signOut();
    notifyListeners();
  }
}
