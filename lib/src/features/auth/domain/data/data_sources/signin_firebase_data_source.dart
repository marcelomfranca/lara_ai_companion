import 'package:firebase_auth/firebase_auth.dart';

abstract interface class SignInFirebaseDataSource {
  Future<User?> signIn({required String email, required String password});
}
