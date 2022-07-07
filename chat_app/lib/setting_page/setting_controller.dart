import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final settingControllerProvider =
    ChangeNotifierProvider<SettingController>((ref) {
  return SettingController(ref.read);
});

class SettingController extends ChangeNotifier {
  final auth = FirebaseAuth.instance;
  final Reader _reader;
  SettingController(this._reader);

  Future<void> logOut() async {
    await auth.signOut();
    notifyListeners();
  }
}
