import 'package:firebase_auth/firebase_auth.dart';
import '../../domain/data/data_sources/signin_firebase_data_source.dart';

final class SignInFirebaseDataSourceImpl implements SignInFirebaseDataSource {
  SignInFirebaseDataSourceImpl(this._firebaseAuth);

  final FirebaseAuth _firebaseAuth;

  @override
  Future<User?> signIn({
    required String email,
    required String password,
  }) async {
    final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    return userCredential.user;
  }
}
