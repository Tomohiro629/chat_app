import 'package:chat_app/entity/chat_room.dart';
import 'package:chat_app/entity/message.dart';
import 'package:chat_app/repository/chat_room_repository.dart';
import 'package:chat_app/repository/message_repository.dart';
import 'package:chat_app/service/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final chatControllerProvider = ChangeNotifierProvider<ChatController>((ref) {
  return ChatController(ref.read);
});

class ChatController extends ChangeNotifier {
  bool loading = false;
  final Reader _reader;
  ChatController(this._reader);

  addLastMessage({required String chatId, required String lastMessage}) async {
    _reader(chatRepositoryProvider)
        .addLastMessage(chatId: chatId, lastMessage: lastMessage);
  }

  Future<void> addMesseage({
    required String messageText,
    required String chatId,
  }) async {
    changeLoadingStatus(true);
    final message = Message.create(
      chatId: chatId,
      messageText: messageText,
      userId: _reader(authServiceProvider).userId,
    );
    await _reader(messageRepositoryProvider).setMesseage(message: message);

    changeLoadingStatus(false);
  }

  Query<Message> messageQuery({required String chatId}) {
    return _reader(messageRepositoryProvider)
        .messageQuery(_reader(authServiceProvider).userId, chatId: chatId);
  }

  void changeLoadingStatus(bool status) {
    loading = status;
    notifyListeners();
  }

  Future<void> deleteMesseage({
    required Message message,
  }) async {
    //firestoreのデータ削除
    await _reader(messageRepositoryProvider).deleteMesseage(message: message);
  }
}
