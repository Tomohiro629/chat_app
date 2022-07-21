import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class ChatRoom {
  ChatRoom({
    required this.chatName,
    required this.addTime,
    required this.roomId,
    required this.userIds,
  });

  factory ChatRoom.create({
    required String chatName,
    required String currentUserId,
    required String partnerUserId,
  }) {
    return ChatRoom(
        roomId: const Uuid().v4(),
        chatName: chatName,
        addTime: DateFormat("yyyy年MM月dd日").format(DateTime.now()),
        userIds: [currentUserId, partnerUserId]);
  }

  factory ChatRoom.fromJson(Map<String, dynamic> map) {
    return ChatRoom(
        chatName: map['chatRoomName'],
        addTime: map['addTime'],
        roomId: map['roomId'],
        userIds: (map['userIds'] as List<dynamic>).cast<String>());
  }

  Map<String, dynamic> toJson() {
    return {
      'chatRoomName': chatName,
      'addTime': addTime,
      'roomId': roomId,
      'userIds': userIds,
    };
  }

  final String chatName;
  final String addTime;
  final String roomId;
  final List<String> userIds;
}
