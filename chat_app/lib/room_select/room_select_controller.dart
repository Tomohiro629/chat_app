import 'package:chat_app/entity/chat.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

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
    required String chatName,
  }) async {
    final chat = Chat(
        roomId: const Uuid().v4(),
        chatName: chatName,
        addTime: DateFormat("yyyy年MM月dd日").format(DateTime.now()));
    await _firestore
        .collection("chat_rooms")
        .doc(chat.roomId)
        .set(chat.toJson());
  }

  Stream<List<Chat>> fetchChatRoomStream() {
    final snapshots = _firestore.collection('chat_rooms').snapshots();

    return snapshots
        .map((qs) => qs.docs.map((doc) => Chat.fromJson(doc.data())).toList());
  }

  Future<void> deleteChatRoom({
    required String chatName,
  }) async {
    await _firestore.collection("chat_rooms").doc(chatName).delete();
  }
}
