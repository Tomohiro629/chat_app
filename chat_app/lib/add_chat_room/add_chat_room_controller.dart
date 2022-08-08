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

  Future<void> setChatRoom({
    required String partnerId,
    required String groupUserId,
    required String currentUserName,
    required String partnerUserName,
    required String currentUserImage,
    required String partnerUserImage,
  }) async {
    final chat = ChatRoom.create(
      currentUserId: _reader(authServiceProvider).userId,
      partnerUserId: partnerId,
      groupUserId: groupUserId,
      currentUserName: currentUserName,
      partnerUserName: partnerUserName,
      groupUserName: "",
      currentUserImage: currentUserImage,
      partnerUserImage: partnerUserImage,
      groupUserImage: "",
    );

    await _reader(chatRepositoryProvider).setChatRoom(chat: chat);
    notifyListeners();
  }
}
