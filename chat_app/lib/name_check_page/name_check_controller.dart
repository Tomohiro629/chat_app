import 'package:chat_app/repository/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final nameCheckControllerProvider =
    ChangeNotifierProvider<NameCheckController>((ref) {
  return NameCheckController(ref.read);
});

class NameCheckController extends ChangeNotifier {
  final Reader _reader;
  NameCheckController(
    this._reader,
  );

  Future<void> getChat({required String inputName}) async {
    {
      await _reader(userRepositoryProvider).getChat();
    }
  }
}
