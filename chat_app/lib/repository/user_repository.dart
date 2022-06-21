import 'package:chat_app/entity/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userRepositoryProvider = Provider(((ref) {
  return UserRepository();
}));

class UserRepository {
  final _firestore = FirebaseFirestore.instance;

  Future<void> setUser({
    required User user,
  }) async {
    await _firestore
        .collection("user")
        .doc(user.userId)
        .set(user.toJson(), SetOptions(merge: true));
  }

  Future<void> deleteUser({
    required User user,
  }) async {
    await _firestore.collection("user").doc(user.userId).delete();
  }
}
