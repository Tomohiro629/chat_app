import 'package:chat_app/entity/chat_room.dart';
import 'package:chat_app/repository/chat_room_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final roomSelectControllerProvider =
    ChangeNotifierProvider<RoomSelectController>((ref) {
  return RoomSelectController(ref.read);
});

class RoomSelectController extends ChangeNotifier {
  final Reader _reader;
  RoomSelectController(this._reader);

  Future<void> addChatRoom({
    required String chatName,
    required String userId,
  }) async {
    final chat = ChatRoom.create(chatName: chatName, userId: userId);
    await _reader(chatRepositoryProvider).addChatRoom(chat: chat);
  }

  Stream<List<ChatRoom>> fetchChatRoomStream() {
    return _reader(chatRepositoryProvider).fetchChatRoomStream();
  }

  Future<void> deleteChatRoom({
    required ChatRoom chat,
  }) async {
    await _reader(chatRepositoryProvider).deleteChatRoom(chat: chat);
  }
}
