import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class Message {
  Message({
    required this.chatId,
    required this.userId,
    this.message = "",
    this.imageURL = "",
    this.currentUserImage = "",
    required this.messageId,
    required this.timeStamp,
  });

  factory Message.create({
    required String chatId,
    required String userId,
    required String message,
    required String imageURL,
    required String currentUserImage,
  }) {
    return Message(
      messageId: const Uuid().v4(),
      timeStamp: DateTime.now(),
      chatId: chatId,
      userId: userId,
      message: message,
      imageURL: imageURL,
      currentUserImage: currentUserImage,
    );
  }

  factory Message.fromJson(Map<String, dynamic> map) {
    return Message(
      messageId: map['messageId'],
      timeStamp: (map['timeStamp']! as Timestamp).toDate(),
      chatId: map['chatId'],
      userId: map['senderUserId'],
      message: map['message'],
      imageURL: map['imageURL'],
      currentUserImage: map['currentUserImage'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'messageId': messageId,
      'timeStamp': timeStamp,
      'chatId': chatId,
      'senderUserId': userId,
      'message': message,
      'imageURL': imageURL,
      'currentUserImage': currentUserImage,
    };
  }

  final String messageId;
  final DateTime timeStamp;
  final String chatId;
  final String userId;
  final String message;
  final String? imageURL;
  final String? currentUserImage;
}
