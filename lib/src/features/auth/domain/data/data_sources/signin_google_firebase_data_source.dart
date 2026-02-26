import 'package:firebase_auth/firebase_auth.dart';

abstract interface class SignInWithGoogleFirebaseDataSource {
  Future<User?> signIn();
}
