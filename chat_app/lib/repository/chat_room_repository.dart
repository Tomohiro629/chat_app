import 'package:chat_app/entity/chat_room.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

final chatRepositoryProvider = Provider(((ref) {
  return ChatRoomRepository();
}));

class ChatRoomRepository {
  final _firestore = FirebaseFirestore.instance;

  Future<void> addLastMessage({
    required String chatId,
    required String lastMessage,
  }) async {
    await _firestore.collection("chat_rooms").doc(chatId).update({
      "lastMessage": lastMessage,
      "sendTime": DateFormat("HH:mm").format(DateTime.now()),
      "timeStamp": DateFormat("MM月dd日 HH時mm分ss秒").format(DateTime.now()),
    });
  }

  Future<void> setChatRoom({
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

  Query<ChatRoom> chatRoomQuery(
    String userId,
  ) {
    final query = _firestore
        .collection('chat_rooms')
        .where('userIds', arrayContains: userId);
    // .orderBy("timeStamp", descending: true);
    return query.withConverter<ChatRoom>(
      fromFirestore: (snapshot, _) => ChatRoom.fromJson(snapshot.data()!),
      toFirestore: (chatRoom, _) => chatRoom.toJson(),
    );
  }

  Future<void> updateChatRoom(
      {required String editChatName, required String roomId}) async {
    _firestore
        .collection('chat_rooms')
        .doc(roomId)
        .update({"chatRoomName": editChatName});
  }
}
