import 'package:chat_app/repository/chat_room_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final addUserControllerProvider = ChangeNotifierProvider<AddUserPage>((ref) {
  return AddUserPage(ref.read);
});

class AddUserPage extends ChangeNotifier {
  final Reader reader;
  AddUserPage(this.reader);

  Future<void> addUser({required String userId}) async {
    await reader(chatRepositoryProvider).updateChatRoom(userId: userId);
  }
}
