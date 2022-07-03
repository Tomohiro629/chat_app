import 'package:chat_app/entity/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userRepositoryProvider = Provider(((ref) {
  return UserRepository();
}));

class UserRepository {
  final _firestore = FirebaseFirestore.instance;

  Future<void> getChat() async {
    await _firestore.collection("chat_rooms").get();
  }

  Future<void> setUser({
    required Users user,
  }) async {
    await _firestore
        .collection("users")
        .doc("user")
        .set(user.toJson(), SetOptions(merge: true));
  }

  Future<void> deleteUser() async {
    await _firestore.collection("users").doc("user").delete();
  }

  Stream<List<Users>> fetchUserStream() {
    final snapshots = _firestore.collection('users').snapshots();

    return snapshots
        .map((qs) => qs.docs.map((doc) => Users.fromJson(doc.data())).toList());
  }
}
