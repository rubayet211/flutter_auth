import 'package:cloud_firestore/cloud_firestore.dart';

class UserService {
  final CollectionReference users =
      FirebaseFirestore.instance.collection('users');

  Future<void> createUser(String userId, String username, String email) async {
    try {
      await users.doc(userId).set({
        'username': username,
        'email': email,
        'createdAt': Timestamp.now(),
      });
    } catch (e) {
      throw Exception('Failed to create user');
    }
  }

  Future<DocumentSnapshot> getUserById(String userId) async {
    try {
      DocumentSnapshot docSnapshot = await users.doc(userId).get();
      return docSnapshot;
    } catch (e) {
      throw Exception('Failed to get user');
    }
  }
}
