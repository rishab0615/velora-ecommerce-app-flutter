import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import '../../models/user_model.dart';

class UserService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> createUser(
UserModel user
  ) async {
    try {
      await _firestore
          .collection('users')
          .doc(user.uid)
          .set(user.toMap());

      debugPrint("User created in Firestore: $user.uid");
    } catch (e) {
      debugPrint("Firestore user creation failed: $e");
      rethrow;
    }
  }
}