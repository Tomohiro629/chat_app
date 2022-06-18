import 'package:chat_app/entity/message.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

final chatControllerProvider = ChangeNotifierProvider<ChatController>((ref) {
  return ChatController();
});

class ChatController extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool loading = false;

  Future<void> addMesseage({
    required String messageText,
    required String chatId,
  }) async {
    changeLoadingStatus(true);
    final message = Message(
      messageId: const Uuid().v4(),
      message: messageText,
      sendTime: DateFormat("yyyy年MM月dd日 hh時mm分").format(DateTime.now()),
    );
    //firestoreにメッセージを追加
    await _firestore
        .collection("chat_rooms")
        .doc(chatId)
        .collection("messages")
        .doc(message.messageId)
        .set(message.toJson());

    changeLoadingStatus(false);
  }

  Future<void> deleteMesseage({
    required String chatId,
    required String messageId,
  }) async {
    //firestoreのデータ削除
    await _firestore
        .collection("chat_rooms")
        .doc(chatId)
        .collection("messages")
        .doc(messageId)
        .delete();
  }

  Stream<List<Message>> fetchMessagesStream(String chatId) {
    final snapshots = _firestore
        .collection('chat_rooms')
        .doc("room1")
        .collection("messages")
        .orderBy('sendTime', descending: true)
        .snapshots();

    return snapshots.map(
        (qs) => qs.docs.map((doc) => Message.fromJson(doc.data())).toList());
  }

  void changeLoadingStatus(bool status) {
    loading = status;
    notifyListeners();
  }
}
