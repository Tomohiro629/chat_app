import 'package:chat_app/entity/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final messageRepositoryProvider = Provider(((ref) {
  return MessageRepository();
}));

class MessageRepository {
  final _firestore = FirebaseFirestore.instance;

  Future<void> setMesseage({
    required Message message,
  }) async {
    //firestoreにメッセージを追加
    await _firestore
        .collection("chat_rooms")
        .doc(message.chatId)
        .collection("messages")
        .doc(message.messageId)
        .set(message.toJson(), SetOptions(merge: true));
  }

  Future<void> deleteMesseage({
    required Message message,
  }) async {
    //firestoreのデータ削除
    await _firestore
        .collection("chat_rooms")
        .doc(message.chatId)
        .collection("messages")
        .doc(message.messageId)
        .delete();
  }

  Query<Message> messageQuery(String userId, {required String chatId}) {
    final query = _firestore
        .collection('chat_rooms')
        .doc(chatId)
        .collection("messages")
        .orderBy('sendTime', descending: true);
    return query.withConverter<Message>(
      fromFirestore: (snapshot, _) => Message.fromJson(snapshot.data()!),
      toFirestore: (message, _) => message.toJson(),
    );
  }
}
