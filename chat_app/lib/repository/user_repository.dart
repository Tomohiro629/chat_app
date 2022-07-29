import 'package:chat_app/entity/chat_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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
      await _firestore
          .collection("users")
          .doc(user.userId)
          .set(user.toJson(), SetOptions(merge: true));
    } catch (e) {
      const Dialog(
        child: Text("Registartion Error"),
      );
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

  Future<DocumentSnapshot<Map<String, dynamic>>> getUserDate(
      {required String userId}) {
    return _firestore.collection("users").doc(userId).get();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> searchUserData(
    String inputUserName,
  ) {
    return _firestore
        .collection('users')
        .where('userName', isEqualTo: inputUserName)
        .get();
  }

  Future<void> updateUserName(
      {required String editUserName, required String userId}) async {
    _firestore
        .collection('users')
        .doc(userId)
        .update({"userName": editUserName});
  }
}
