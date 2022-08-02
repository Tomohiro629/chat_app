import 'package:chat_app/entity/message.dart';
import 'package:chat_app/entity/send_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final sendImageRepositoryProvider = Provider(((ref) {
  return SendImageRepository();
}));

class SendImageRepository {
  final _firestore = FirebaseFirestore.instance;

  Future<void> setImageURL({required SendImage sendImage}) async {
    await _firestore
        .collection("chat_rooms")
        .doc(sendImage.chatId)
        .collection("messages")
        .doc(sendImage.messageId)
        .set(sendImage.toJson(), SetOptions(merge: true));
  }

  Query<SendImage> sendImageQuery(String userId, {required String chatId}) {
    final query = _firestore
        .collection('chat_rooms')
        .doc(chatId)
        .collection("messages")
        .orderBy('timeStamp', descending: true);
    return query.withConverter<SendImage>(
      fromFirestore: (snapshot, _) => SendImage.fromJson(snapshot.data()!),
      toFirestore: (message, _) => message.toJson(),
    );
  }
}
