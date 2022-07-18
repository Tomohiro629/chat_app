import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class ChatRoom {
  ChatRoom({
    required this.chatName,
    required this.addTime,
    required this.roomId,
    required this.currentUserId,
  });

  factory ChatRoom.create({
    required String chatName,
    required String currentUserId,
  }) {
    return ChatRoom(
        roomId: const Uuid().v4(),
        chatName: chatName,
        addTime: DateFormat("yyyy年MM月dd日").format(DateTime.now()),
        currentUserId: currentUserId);
  }

  factory ChatRoom.fromJson(Map<String, dynamic> map) {
    return ChatRoom(
        chatName: map['chatRoomName'],
        addTime: map['addTime'],
        roomId: map['roomId'],
        currentUserId: map['currentUserId']);
  }

  Map<String, dynamic> toJson() {
    return {
      'chatRoomName': chatName,
      'addTime': addTime,
      'roomId': roomId,
      'currentUserId': currentUserId,
    };
  }

  final String chatName;
  final String addTime;
  final String roomId;
  final String currentUserId;
}
