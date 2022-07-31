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

  Future<void> setChatRoom(
      {required String userId,
      required String lastMessage,
      required String sendTime}) async {
    final chat = ChatRoom.create(
        sendTime: sendTime,
        lastMessage: lastMessage,
        currentUserId: _reader(authServiceProvider).userId,
        partnerUserId: userId);
    await _reader(chatRepositoryProvider).setChatRoom(chat: chat);
    notifyListeners();
  }

  Future<void> updateChatRoom(
      {required String editChatName, required String roomId}) async {
    await _reader(chatRepositoryProvider)
        .updateChatRoom(editChatName: editChatName, roomId: roomId);
  }
}
