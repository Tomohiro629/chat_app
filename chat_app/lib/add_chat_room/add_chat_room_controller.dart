import 'package:chat_app/entity/chat_room.dart';
import 'package:chat_app/repository/chat_room_repository.dart';
import 'package:chat_app/service/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final addChatRoomControllerProvider =
    ChangeNotifierProvider<AddChatRoomController>((ref) {
  return AddChatRoomController(ref.read);
});

class AddChatRoomController extends ChangeNotifier {
  final Reader _reader;
  AddChatRoomController(this._reader);

  Future<void> addChatRoom({
    required String chatName,
    required String userId,
  }) async {
    final chat = ChatRoom.create(
        chatName: chatName,
        currentUserId: _reader(authServiceProvider).userId,
        partnerUserId: userId);
    await _reader(chatRepositoryProvider).addChatRoom(chat: chat);
  }
}
