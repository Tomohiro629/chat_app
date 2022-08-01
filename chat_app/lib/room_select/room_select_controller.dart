import 'package:chat_app/entity/chat_room.dart';
import 'package:chat_app/repository/chat_room_repository.dart';
import 'package:chat_app/repository/user_repository.dart';
import 'package:chat_app/service/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final roomSelectControllerProvider =
    ChangeNotifierProvider<RoomSelectController>((ref) {
  return RoomSelectController(ref.read);
});

class RoomSelectController extends ChangeNotifier {
  final Reader _reader;
  RoomSelectController(this._reader);

  Query<ChatRoom> chatRoomQuery() {
    return _reader(chatRepositoryProvider).chatRoomQuery(
      _reader(authServiceProvider).userId,
    );
  }

  Future<void> updataChatRoomName(
      {required String editUserName, required String userId}) async {
    await _reader(userRepositoryProvider)
        .updateUserName(editUserName: editUserName, userId: userId);
  }

  Future<void> deleteChatRoom({
    required ChatRoom chat,
  }) async {
    await _reader(chatRepositoryProvider).deleteChatRoom(chat: chat);
  }
}
