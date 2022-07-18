import 'package:chat_app/entity/chat_room.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final chatRepositoryProvider = Provider(((ref) {
  return ChatRoomRepository();
}));

class ChatRoomRepository {
  final _firestore = FirebaseFirestore.instance;

  Future<void> addChatRoom({
    required ChatRoom chat,
  }) async {
    await _firestore
        .collection("chat_rooms")
        .doc(chat.roomId)
        .set(chat.toJson(), SetOptions(merge: true));
  }

  Future<void> deleteChatRoom({
    required ChatRoom chat,
  }) async {
    await _firestore.collection("chat_rooms").doc(chat.roomId).delete();
  }

  Stream<List<ChatRoom>> fetchChatRoomStream(
    String userId,
  ) {
    final snapshots = _firestore.collection('chat_rooms').snapshots();

    return snapshots.map(
        (qs) => qs.docs.map((doc) => ChatRoom.fromJson(doc.data())).toList());
  }
}
