import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class SendImage {
  SendImage({
    required this.imageURL,
    required this.messageId,
    required this.timeStamp,
    required this.chatId,
    required this.userId,
  });

  factory SendImage.create({
    required String imageURL,
    required String chatId,
    required String userId,
  }) {
    return SendImage(
        imageURL: imageURL,
        messageId: const Uuid().v4(),
        timeStamp: DateTime.now(),
        chatId: chatId,
        userId: userId);
  }

  factory SendImage.fromJson(Map<String, dynamic> map) {
    return SendImage(
        imageURL: map['imageURL'],
        messageId: map['messageId'],
        timeStamp: (map['timeStamp']! as Timestamp).toDate(),
        chatId: map['chatId'],
        userId: map['senderUserId']);
  }

  Map<String, dynamic> toJson() {
    return {
      'imageURL': imageURL,
      'messageId': messageId,
      'timeStamp': timeStamp,
      'chatId': chatId,
      'senderUserId': userId,
    };
  }

  final String imageURL;
  final String messageId;
  final DateTime timeStamp;
  final String chatId;
  final String userId;
}
