import 'package:chat_app/entity/users.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userRepositoryProvider = Provider(((ref) {
  return UserRepository();
}));

class UserRepository {
  final _firestore = FirebaseFirestore.instance;

  Future<void> setUser({
    required Users user,
  }) async {
    await _firestore
        .collection("users")
        .doc(user.userId)
        .set(user.toJson(), SetOptions(merge: true));
  }

  Future<void> deleteUser(String userId) async {
    await _firestore.collection("users").doc(userId).delete();
  }

  Stream<Users?> fetchUserStream(String userId) {
    final snapshots = _firestore.collection('users').doc(userId).snapshots();

    return snapshots.map(
        ((doc) => doc.data() == null ? null : Users.fromJson(doc.data()!)));
  }

  Stream<List<Users>> fetchUsersStream() {
    final snapshots = _firestore.collection('users').snapshots();

    return snapshots
        .map((qs) => qs.docs.map((doc) => Users.fromJson(doc.data())).toList());
  }
}
