import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class ChatRoom {
  ChatRoom({
    required this.chatName,
    required this.addTime,
    required this.roomId,
  });

  factory ChatRoom.create({
    required String chatName,
  }) {
    return ChatRoom(
        roomId: const Uuid().v4(),
        chatName: chatName,
        addTime: DateFormat("yyyy年MM月dd日").format(DateTime.now()));
  }

  factory ChatRoom.fromJson(Map<String, dynamic> map) {
    return ChatRoom(
        chatName: map['chatRoomName'],
        addTime: map['addTime'],
        roomId: map['roomId']);
  }

  Map<String, dynamic> toJson() {
    return {
      'chatRoomName': chatName,
      'addTime': addTime,
      'roomId': roomId,
    };
  }

  final String chatName;
  final String addTime;
  final String roomId;
}
