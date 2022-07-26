import 'package:chat_app/entity/chat_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userRepositoryProvider = Provider(((ref) {
  return UserRepository();
}));

class UserRepository {
  final _firestore = FirebaseFirestore.instance;
  Future<void> setUser({
    required ChatUser user,
  }) async {
    try {
      await _firestore.collection("users").doc(user.userId).set(
            user.toJson(),
          );
    } catch (e) {
      print(e);
    }
  }

  Future<void> deleteUser(String userId) async {
    await _firestore.collection("users").doc(userId).delete();
  }

  Stream<ChatUser?> fetchUserStream(String userId) {
    final snapshots = _firestore.collection('users').doc(userId).snapshots();

    return snapshots.map(
        ((doc) => doc.data() == null ? null : ChatUser.fromJson(doc.data()!)));
  }

  Stream<List<ChatUser>> fetchUsersStream() {
    final snapshots = _firestore.collection('users').snapshots();

    return snapshots.map(
        (qs) => qs.docs.map((doc) => ChatUser.fromJson(doc.data())).toList());
  }

  Future<void> getUser(String userId) async {
    _firestore
        .collection('users')
        .doc(userId)
        .get()
        .then((DocumentSnapshot doc) {
      final data = doc.data() as Map<String, dynamic>;
    });
  }

  Future<void> updateUserName(
      {required String editUserName, required String userId}) async {
    _firestore
        .collection('users')
        .doc(userId)
        .update({"userName": editUserName});
  }
}
