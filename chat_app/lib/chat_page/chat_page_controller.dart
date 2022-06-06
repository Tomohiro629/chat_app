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
  Stream<List<Chat>> fetchChatSteram() {
    final snapshot = _firestore.collection('chatmessage').snapshots();

    return snapshot.map((event) => event.docs.map((doc) {
          Map<String, dynamic> data = doc.data();
          final String id = data['id'];
          final String messeage = data['messeage'];

          return Chat(id: id, messeage: messeage);
        }).toList());
  }

  Future<void> deleteMesseage(String id) async {
    await _firestore.collection("chatmessage").doc(id).delete();
  }
}
