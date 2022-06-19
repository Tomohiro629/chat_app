import 'package:chat_app/entity/chat.dart';
import 'package:chat_app/repository/chat_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

final roomSelectControllerProvider =
    ChangeNotifierProvider<RoomSelectController>((ref) {
  return RoomSelectController(ref.read);
});

class RoomSelectController extends ChangeNotifier {
  final auth = FirebaseAuth.instance;
  final Reader _reader;
  RoomSelectController(this._reader);

  Future<void> logOut() async {
    await auth.signOut();
    notifyListeners();
  }

  Future<void> addChatRoom({
    required String chatName,
  }) async {
    final chat = Chat(
        roomId: const Uuid().v4(),
        chatName: chatName,
        addTime: DateFormat("yyyy年MM月dd日").format(DateTime.now()));
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
