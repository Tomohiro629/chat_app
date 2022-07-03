import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class Chat {
  Chat({
    required this.chatName,
    required this.addTime,
    required this.roomId,
  });

  factory Chat.create({
    required String chatName,
  }) {
    return Chat(
        roomId: const Uuid().v4(),
        chatName: chatName,
        addTime: DateFormat("yyyy年MM月dd日").format(DateTime.now()));
  }

  factory Chat.fromJson(Map<String, dynamic> map) {
    return Chat(
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
