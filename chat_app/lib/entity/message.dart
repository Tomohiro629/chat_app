import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class Message {
  Message({
    this.message = "",
    this.imageURL = "",
    required this.messageId,
    required this.timeStamp,
    required this.chatId,
    required this.userId,
  });

  factory Message.create({
    required String chatId,
    required String userId,
  }) {
    return Message(
      messageId: const Uuid().v4(),
      timeStamp: DateTime.now(),
      chatId: chatId,
      userId: userId,
    );
  }

  factory Message.fromJson(Map<String, dynamic> map) {
    return Message(
      message: map['message'],
      imageURL: map['imageURL'],
      messageId: map['messageId'],
      timeStamp: (map['timeStamp']! as Timestamp).toDate(),
      chatId: map['chatId'],
      userId: map['senderUserId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'imageURL': imageURL,
      'messageId': messageId,
      'timeStamp': timeStamp,
      'chatId': chatId,
      'senderUserId': userId,
    };
  }

  final String message;
  final String imageURL;
  final String messageId;
  final DateTime timeStamp;
  final String chatId;
  final String userId;
}
