import 'package:chat_app/entity/chat_user.dart';
import 'package:chat_app/repository/user_repository.dart';
import 'package:chat_app/service/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final addGroupProvider = ChangeNotifierProvider<AddGroupController>((ref) {
  return AddGroupController(ref.read);
});

class AddGroupController extends ChangeNotifier {
  final Reader _reader;
  AddGroupController(this._reader);

  Query<ChatUser> userListQuery() {
    return _reader(userRepositoryProvider)
        .userListQuery(currentUserId: _reader(authServiceProvider).userId);
  }
}
