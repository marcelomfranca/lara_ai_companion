import 'package:firebase_auth/firebase_auth.dart';

abstract interface class CreateAccountFirebaseDataSource {
  Future<User?> create({
    required String name,
    required String email,
    required String password,
  });
}
