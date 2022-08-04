import 'package:chat_app/entity/chat_user.dart';
import 'package:chat_app/repository/user_repository.dart';
import 'package:chat_app/service/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userListProvider = ChangeNotifierProvider<UserListController>((ref) {
  return UserListController(ref.read);
});

class UserListController extends ChangeNotifier {
  final Reader _reader;
  bool checked = false;
  UserListController(this._reader);

  Query<ChatUser> userListQuery() {
    return _reader(userRepositoryProvider)
        .userListQuery(currentUserId: _reader(authServiceProvider).userId);
  }

  void selectCheckBox(value) {
    checked = value;
  }
}
