import 'package:uuid/uuid.dart';

class ChatRoom {
  ChatRoom({
    required this.chatName,
    required this.roomId,
    this.sendTime = "",
    this.lastMessage = "",
    required this.userImageURL,
    required this.userIds,
  });

  factory ChatRoom.create({
    required String chatName,
    required String currentUserId,
    required String partnerUserId,
    required String lastMessage,
    required String sendTime,
    required String userImageURL,
  }) {
    return ChatRoom(
        roomId: const Uuid().v4(),
        chatName: chatName,
        userImageURL: userImageURL,
        userIds: [currentUserId, partnerUserId]);
  }

  factory ChatRoom.fromJson(Map<String, dynamic> map) {
    return ChatRoom(
        chatName: map['chatRoomName'],
        sendTime: map['sendTime'],
        roomId: map['roomId'],
        lastMessage: map['lastMessage'],
        userImageURL: map['userImageURL'],
        userIds: (map['userIds'] as List<dynamic>).cast<String>());
  }

  Map<String, dynamic> toJson() {
    return {
      'chatRoomName': chatName,
      'roomId': roomId,
      'userImageURL': userImageURL,
      'userIds': userIds,
    };
  }

  final String chatName;
  final String roomId;
  final String? lastMessage;
  final String? sendTime;
  final String userImageURL;
  final List<String> userIds;
}
