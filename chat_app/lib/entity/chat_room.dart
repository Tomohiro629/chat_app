import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class ChatRoom {
  ChatRoom({
    required this.roomId,
    this.lastMessage = "",
    this.timeStamp,
    required this.userIds,
    required this.userNames,
  });

  factory ChatRoom.create({
    required String currentUserId,
    required String partnerUserId,
    required String groupUserId,
    required String currentUserName,
    required String partnerUserName,
    required String groupUserName,
  }) {
    return ChatRoom(
        roomId: const Uuid().v4(),
        userIds: [currentUserId, partnerUserId, groupUserId],
        userNames: [currentUserName, partnerUserName, groupUserName]);
  }

  factory ChatRoom.fromJson(Map<String, dynamic> map) {
    return ChatRoom(
      roomId: map['roomId'],
      lastMessage: map['lastMessage'],
      timeStamp: map['timeStamp'] != null
          ? (map['timeStamp']! as Timestamp).toDate()
          : null,
      userIds: (map['userIds'] as List<dynamic>).cast<String>(),
      userNames: (map['userNames'] as List<dynamic>).cast<String>(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'roomId': roomId,
      'userIds': userIds,
      'userNames': userNames,
      'timeStamp': timeStamp,
      'lastMessage': lastMessage,
    };
  }

  final String roomId;
  final String? lastMessage;
  final DateTime? timeStamp;
  final List<String> userIds;
  final List<String> userNames;
}
