import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class Message {
  Message({
    required this.message,
    required this.messageId,
    required this.timeStamp,
    required this.chatId,
    required this.userId,

    // this.imageURL = "",
  });

  factory Message.create({
    required String chatId,
    required String userId,
    required String messageText,
  }) {
    return Message(
      messageId: const Uuid().v4(),
      message: messageText,
      timeStamp: DateTime.now(),
      chatId: chatId,
      userId: userId,
      // imageURL: imageURL!,
    );
  }

  factory Message.fromJson(Map<String, dynamic> map) {
    return Message(
      message: map['message'],
      messageId: map['messageId'],
      timeStamp: (map['timeStamp']! as Timestamp).toDate(),
      chatId: map['chatId'],
      userId: map['senderUserId'],
      // imageURL: map["imageURL"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'messageId': messageId,
      'timeStamp': timeStamp,
      'chatId': chatId,
      'senderUserId': userId,
    };
  }

  final String message;
  final String messageId;
  final DateTime timeStamp;
  final String chatId;
  final String userId;
  // final String? imageURL;
}
