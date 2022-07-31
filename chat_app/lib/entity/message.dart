import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class Message {
  Message({
    required this.message,
    required this.messageId,
    required this.sendTime,
    required this.chatId,
    required this.userId,
    // this.imageURL = "",
  });

  factory Message.create({
    required String chatId,
    required String userId,
    required String messageText,
    // required String? imageURL,
  }) {
    return Message(
      messageId: const Uuid().v4(),
      message: messageText,
      sendTime: DateFormat("MM月dd日 HH時mm分ss秒").format(DateTime.now()),
      chatId: chatId,
      userId: userId,
      // imageURL: imageURL!,
    );
  }

  factory Message.fromJson(Map<String, dynamic> map) {
    return Message(
      message: map['message'],
      messageId: map['messageId'],
      sendTime: map['sendTime'],
      chatId: map['chatId'],
      userId: map['senderUserId'],
      // imageURL: map["imageURL"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'messageId': messageId,
      'sendTime': sendTime,
      'chatId': chatId,
      'senderUserId': userId,
    };
  }

  final String message;
  final String messageId;
  final String sendTime;
  final String chatId;
  final String userId;
  // final String? imageURL;
}
