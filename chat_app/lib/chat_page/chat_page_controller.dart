import 'package:chat_app/entity/chat.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

final chatControllerProvider = ChangeNotifierProvider<ChatController>((ref) {
  return ChatController();
});

class ChatController extends ChangeNotifier {
  final id = Uuid().v4();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void getMessages(Chat chat) async {
    //firestoreからデータ読み込み
    final getData = await _firestore.collection("chat_room").doc(chat.id).get();
  }

  String messeage = '';
  void newMesseage(String? newmesseage) {
    if (newmesseage != null && newmesseage.length > 0) {
      messeage = newmesseage;
    } else {
      const Text('入力してください。');
    }
    notifyListeners();
  }

  Future<void> addMesseage() async {
    //firestoreにメッセージを追加
    await _firestore
        .collection("chat_room")
        .doc(id)
        .collection("chat_room")
        .add({
      'id': id,
      'messeage': messeage,
    });
    notifyListeners();
  }

  Future<void> deleteMesseage() async {
    await _firestore.collection("chat_room").doc(id).delete();
    notifyListeners();
  }
}
