import 'package:chat_app/entity/chat.dart';
import 'package:chat_app/repository/chat_repository.dart';
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
  }) async {
    final chat = Chat.create(chatName: chatName);
    await _reader(chatRepositoryProvider).addChatRoom(chat: chat);
  }

  Stream<List<Chat>> fetchChatRoomStream() {
    return _reader(chatRepositoryProvider).fetchChatRoomStream();
  }

  Future<void> deleteChatRoom({
    required Chat chat,
  }) async {
    await _reader(chatRepositoryProvider).deleteChatRoom(chat: chat);
  }
}
