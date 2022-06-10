import 'package:chat_app/entity/chat.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

final chatControllerProvider = ChangeNotifierProvider<ChatController>((ref) {
  return ChatController();
});

class ChatController extends ChangeNotifier {
  final id = const Uuid().v4();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool loading = false;

  onPressLoading() async {
    //ローディング画面の表示
    loading = true;
    await Future.delayed(
      const Duration(milliseconds: 5000),
    );
    loading = false;
    notifyListeners();
  }

  void getMessages(Chat chat) async {
    //firestoreからデータ読み込み
    final getData = await _firestore.collection("chat_room").doc(chat.id).get();

    notifyListeners();
  }

  Future<void> addMesseage(String messeage) async {
    //firestoreにメッセージを追加
    await _firestore.collection("chat_room").add({
      'id': id,
      'messeage': messeage,
    });
    notifyListeners();
  }

  deleteMesseage() async {
    //firestoreのデータ削除
    await _firestore.collection("chat_room").doc(id).delete();
    notifyListeners();
  }
}
