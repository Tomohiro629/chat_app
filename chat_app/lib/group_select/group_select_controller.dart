import 'package:chat_app/entity/chat_room.dart';
import 'package:chat_app/repository/chat_room_repository.dart';
import 'package:chat_app/service/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final groupSelectControllerProvider =
    ChangeNotifierProvider<GroupSelectController>((ref) {
  return GroupSelectController(ref.read);
});

class GroupSelectController extends ChangeNotifier {
  final Reader _reader;
  GroupSelectController(this._reader);

  Query<ChatRoom> groupQuery() {
    return _reader(chatRepositoryProvider).chatRoomQuery(
      _reader(authServiceProvider).userId,
    );
  }
}
