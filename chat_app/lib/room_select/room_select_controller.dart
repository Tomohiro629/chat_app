import 'package:chat_app/entity/chat.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final roomSelectControllerProvider =
    ChangeNotifierProvider<RoomSelectController>((ref) {
  return RoomSelectController();
});

class RoomSelectController extends ChangeNotifier {
  final auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  Future<void> logOut() async {
    await auth.signOut();
    notifyListeners();
  }

  Future<void> addChatRoom({
    required String chatId,
    required String chatName,
  }) async {
    final chat = Chat(chatName: chatName);
    await _firestore.collection("chat_rooms").doc(chatName).set(chat.toJson());
  }

  Stream<List<Chat>> fetchChatRoomStream(String chatId) {
    final snapshots = _firestore
        .collection('chat_rooms')
        .doc(chatId)
        .collection("messeages")
        .snapshots();

    return snapshots
        .map((qs) => qs.docs.map((doc) => Chat.fromJson(doc.data())).toList());
  }

  Future<void> deleteChatRoom({
    required String chatId,
  }) async {
    await _firestore.collection("chat_rooms").doc(chatId).delete();
  }
}
