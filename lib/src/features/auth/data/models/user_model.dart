// lib/features/auth/data/models/user_model.dart

import 'package:firebase_auth/firebase_auth.dart';
import 'package:lara_ai/src/core/domain/entities/lara_user.dart';

class UserModel {
  UserModel({
    required this.uid,
    this.email,
    this.displayName,
    this.createdAt,
    this.photoUrl,
    required this.isAnonymous,
  });

  final String uid;
  final String? email;
  final String? displayName;
  final DateTime? createdAt;
  final String? photoUrl;
  final bool isAnonymous;

  factory UserModel.fromFirebase(User firebaseUser, [String? name]) {
    return UserModel(
      uid: firebaseUser.uid,
      email: firebaseUser.email,
      displayName: firebaseUser.displayName ?? name,
      photoUrl: firebaseUser.photoURL,
      createdAt: firebaseUser.metadata.creationTime,
      isAnonymous: firebaseUser.isAnonymous,
    );
  }

  LaraUser toEntity() {
    return LaraUser(
      id: uid,
      email: email ?? '',
      name: displayName,
      photoUrl: photoUrl,
      createdAt: createdAt,
      isGuest: isAnonymous,
    );
  }
}
