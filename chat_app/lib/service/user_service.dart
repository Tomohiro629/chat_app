import 'package:chat_app/entity/chat_user.dart';
import 'package:chat_app/repository/user_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userServiceProvider = ChangeNotifierProvider<UserService>((ref) {
  return UserService(ref.read);
});

class UserService extends ChangeNotifier {
  final Reader _reader;
  UserService(this._reader);
  bool loading = false;

  Future<void> addUser({
    required String userNameText,
    required String userId,
    required String imageURL,
  }) async {
    final user = ChatUser.create(
        userNameText: userNameText, userId: userId, imageURL: imageURL);
    await _reader(userRepositoryProvider).setUser(user: user);
  }

  Stream<ChatUser?> fetchUserStream(String userId) {
    return _reader(userRepositoryProvider).fetchUserStream(userId);
  }

  Stream<List<ChatUser>> fetchUsersStream(String userId) {
    return _reader(userRepositoryProvider).fetchUsersStream();
  }

  Future<void> deleteUser(String userId) async {
    await _reader(userRepositoryProvider).deleteUser(userId);
  }

  void takeCamera() async {
    _reader(userRepositoryProvider).takeCamera();
  }

  void takeGallery() async {
    _reader(userRepositoryProvider).takeGallery();
  }

  void changeLoadingStatus(bool status) {
    loading = status;
    notifyListeners();
  }
}
