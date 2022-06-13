import 'package:chat_app/entity/messeages.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

final chatControllerProvider = ChangeNotifierProvider<ChatController>((ref) {
  return ChatController();
});

class ChatController extends ChangeNotifier {
  String id = const Uuid().v4();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool loading = false;

  Future<void> addMesseage(String messeages) async {
    //firestoreにメッセージを追加
    await _firestore
        .collection("chat_rooms")
        .doc("room1")
        .collection("messeages")
        .add({'messeage': messeages});
    notifyListeners();
  }

  deleteMesseage(String id) async {
    //firestoreのデータ削除
    await _firestore.collection("chat_rooms").doc(id).delete();
    notifyListeners();
  }

  onPressLoading() async {
    //ローディング画面の表示
    loading = true;
    await Future.delayed(
      const Duration(milliseconds: 5000),
    );
    loading = false;
    notifyListeners();
  }
}
