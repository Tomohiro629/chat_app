import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class ChatRoom {
  ChatRoom({
    required this.chatName,
    required this.addTime,
    required this.roomId,
    required this.userId,
  });

  factory ChatRoom.create({
    required String chatName,
    required String userId,
  }) {
    return ChatRoom(
        roomId: const Uuid().v4(),
        chatName: chatName,
        addTime: DateFormat("yyyy年MM月dd日").format(DateTime.now()),
        userId: userId);
  }

  factory ChatRoom.fromJson(Map<String, dynamic> map) {
    return ChatRoom(
        chatName: map['chatRoomName'],
        addTime: map['addTime'],
        roomId: map['roomId'],
        userId: map['currentUserId']);
  }

  Map<String, dynamic> toJson() {
    return {
      'chatRoomName': chatName,
      'addTime': addTime,
      'roomId': roomId,
      'currentUserId': userId,
    };
  }

  final String chatName;
  final String addTime;
  final String roomId;
  final String userId;
}
