import 'package:chat_app/entity/chat.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final nameCheckControllerProvider =
    ChangeNotifierProvider<NameCheckController>((ref) {
  return NameCheckController(ref.read);
});

class NameCheckController extends ChangeNotifier {
  final Reader _reader;
  NameCheckController(this._reader);
  final _firebase = FirebaseFirestore.instance;

  Future<void> getChat(
      {required String roomId, required String inputName}) async {
    print(roomId);
    // if (inputName == userName) {
    //   await _firebase.collection("chat_rooms").doc(roomId).get();
    // } else {
    //   print("error");
    // }
  }
}
