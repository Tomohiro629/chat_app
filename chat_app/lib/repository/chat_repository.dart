import 'package:chat_app/entity/chat.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final chatRepositoryProvider = Provider(((ref) {
  return ChatRepository();
}));

class ChatRepository {
  final _firestore = FirebaseFirestore.instance;

  Future<void> addChatRoom({
    required Chat chat,
  }) async {
    await _firestore
        .collection("chat_rooms")
        .doc(chat.roomId)
        .set(chat.toJson());
  }

  Future<void> deleteChatRoom({
    required Chat chat,
  }) async {
    await _firestore.collection("chat_rooms").doc(chat.roomId).delete();
  }

  Stream<List<Chat>> fetchChatRoomStream() {
    final snapshots = _firestore.collection('chat_rooms').snapshots();

    return snapshots
        .map((qs) => qs.docs.map((doc) => Chat.fromJson(doc.data())).toList());
  }
}
