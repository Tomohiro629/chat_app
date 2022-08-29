import 'package:chat_app/entity/chat_room.dart';
import 'package:chat_app/repository/chat_room_repository.dart';
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
    required String currentUserName,
    required String partnerUserName,
    required String groupName,
    required String currentUserImage,
    required String partnerUserImage,
    required String groupImage,
  }) async {
    final chat = ChatRoom.create(
      currentUserId: chatRoom.userIds[0],
      partnerUserId: chatRoom.userIds[1],
      groupUserId: groupUserId,
      currentUserName: currentUserName,
      partnerUserName: partnerUserName,
      groupUserName: groupName,
      currentUserImage: currentUserImage,
      partnerUserImage: partnerUserImage,
      groupUserImage: groupImage,
    );

    await _reader(chatRepositoryProvider).setChatRoom(chat: chat);
    notifyListeners();
  }
}
