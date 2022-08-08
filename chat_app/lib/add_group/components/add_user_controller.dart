import 'package:chat_app/entity/chat_room.dart';
import 'package:chat_app/repository/chat_room_repository.dart';
import 'package:chat_app/service/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final addGroupControllerProvider =
    ChangeNotifierProvider<AddGroupController>((ref) {
  return AddGroupController(ref.read);
});

class AddGroupController extends ChangeNotifier {
  final Reader _reader;
  AddGroupController(this._reader);
  Future<void> setGroup({
    required ChatRoom chatRoom,
    required String groupUserId,
  }) async {
    final chat = ChatRoom.create(
      currentUserId: _reader(authServiceProvider).userId,
      partnerUserId: chatRoom.userIds[1],
      groupUserId: groupUserId,
    );

    await _reader(chatRepositoryProvider).setChatRoom(chat: chat);
    notifyListeners();
  }
}
