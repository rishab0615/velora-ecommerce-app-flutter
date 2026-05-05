import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String uid;
  final String email;
  final String name;
  final bool isVerified;
  final Timestamp? createdAt;

  UserModel({
    required this.uid,
    required this.email,
    required this.name,
    required this.isVerified,
    this.createdAt,
  });

  // Convert to Map (for Firestore)
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
      'isVerified': isVerified,
      'createdAt': createdAt ?? FieldValue.serverTimestamp(),
    };
  }

  // Create from Firestore
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] ?? '',
      email: map['email'] ?? '',
      name: map['name'] ?? '',
      isVerified: map['isVerified'] ?? false,
      createdAt: map['createdAt'],
    );
  }
}