import 'package:uuid/uuid.dart';

class ChatRoom {
  ChatRoom({
    required this.chatName,
    required this.roomId,
    this.sendTime = "",
    this.lastMessage = "",
    required this.userIds,
  });

  factory ChatRoom.create({
    required String chatName,
    required String currentUserId,
    required String partnerUserId,
    required String lastMessage,
    required String sendTime,
  }) {
    return ChatRoom(
        roomId: const Uuid().v4(),
        chatName: chatName,
        userIds: [currentUserId, partnerUserId]);
  }

  factory ChatRoom.fromJson(Map<String, dynamic> map) {
    return ChatRoom(
        chatName: map['chatRoomName'],
        sendTime: map['sendTime'],
        roomId: map['roomId'],
        lastMessage: map['lastMessage'],
        userIds: (map['userIds'] as List<dynamic>).cast<String>());
  }

  Map<String, dynamic> toJson() {
    return {
      'chatRoomName': chatName,
      'roomId': roomId,
      'userIds': userIds,
    };
  }

  final String chatName;

  final String roomId;
  final String? lastMessage;
  final String? sendTime;
  final List<String> userIds;
}
