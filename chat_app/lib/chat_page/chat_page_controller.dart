import 'package:chat_app/entity/message.dart';
import 'package:chat_app/repository/message_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

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
    final message = Message(
      messageId: const Uuid().v4(),
      message: messageText,
      sendTime: DateFormat("yyyy年MM月dd日 hh時mm分").format(DateTime.now()),
      chatId: chatId,
    );
    await _reader(messageRepositoryProvider).setMesseage(message: message);

    changeLoadingStatus(false);
  }

  Stream<List<Message>> fetchMessagesStream(String chatId) {
    return _reader(messageRepositoryProvider).fetchMessagesStream(chatId);
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
