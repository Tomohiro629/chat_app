import 'package:chat_app/entity/message.dart';
import 'package:chat_app/repository/message_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final chatControllerProvider = ChangeNotifierProvider<ChatController>((ref) {
  return ChatController(ref.read);
});

class ChatController extends ChangeNotifier {
  bool loading = false;
  final Reader _reader;
  ChatController(this._reader);

  Future<void> addMesseage({
    required String messageText,
    required String chatId,
  }) async {
    changeLoadingStatus(true);
    final message = Message.create(
      chatId: chatId,
      messageText: messageText,
    );
    await _reader(messageRepositoryProvider).setMesseage(message: message);

    changeLoadingStatus(false);
  }

  Stream<List<Message>> fetchMessagesStream(String chatId, String userId) {
    return _reader(messageRepositoryProvider)
        .fetchMessagesStream(chatId, userId);
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
