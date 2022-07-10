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
        .collection("users")
        .doc(user.userId)
        .set(user.toJson(), SetOptions(merge: true));
  }

  Future<void> deleteUser(String userId) async {
    await _firestore.collection("users").doc(userId).delete();
  }

  Stream<User?> fetchUserStream(String userId) {
    final snapshots = _firestore.collection('users').doc(userId).snapshots();

    return snapshots
        .map(((doc) => doc.data() == null ? null : User.fromJson(doc.data()!)));
  }

  Stream<List<User>> fetchUsersStream() {
    final snapshots = _firestore.collection('users').snapshots();

    return snapshots
        .map((qs) => qs.docs.map((doc) => User.fromJson(doc.data())).toList());
  }
}
