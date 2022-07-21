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

  Stream<List<ChatRoom>> fetchChatRoomStream(
    String userId,
  ) {
    return _reader(chatRepositoryProvider).fetchChatRoomStream(
      userId,
    );
  }

  Future<void> deleteChatRoom({
    required ChatRoom chat,
  }) async {
    await _reader(chatRepositoryProvider).deleteChatRoom(chat: chat);
  }
}
