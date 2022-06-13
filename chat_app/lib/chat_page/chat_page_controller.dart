import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

final chatControllerProvider = ChangeNotifierProvider<ChatController>((ref) {
  return ChatController();
});

class ChatController extends ChangeNotifier {
  String id = const Uuid().v4();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final sendTime = DateFormat("yyyy年MM月dd日 hh時mm分").format(DateTime.now());
  bool loading = false;

  Future<void> addMesseage1(String messeages) async {
    //firestoreにメッセージを追加
    await _firestore
        .collection("chat_rooms")
        .doc("room1")
        .collection("messeages")
        .add(
      {'messeage': messeages, 'sendTime': sendTime},
    );
    notifyListeners();
  }

  Future<void> addMesseage2(String messeages) async {
    //firestoreにメッセージを追加
    await _firestore
        .collection("chat_rooms")
        .doc("room2")
        .collection("messeages")
        .add(
      {'messeage': messeages, 'sendTime': sendTime},
    );
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
