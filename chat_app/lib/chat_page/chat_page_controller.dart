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

  List<Chat> chats = [];

  void getMessages(Chat chat) async {
    //firestoreからデータ読み込み
    final getData = await _firestore.collection("chat_room").doc(chat.id).get();
  }

  Stream<List<Chat>> fetchMesseageStream() {
    final snapshot = _firestore.collection("chat_room").snapshots();

    return snapshot.map(
      (qs) => qs.docs.map((doc) {
        Map<String, dynamic> data = doc.data();
        final String id = data["id"];
        final String messeage = ["messeage"].toString();

        return Chat(id: id, messeage: messeage);
      }).toList(),
    );
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
    await _firestore.collection("chat_room").doc(id).delete();
    notifyListeners();
  }
}
