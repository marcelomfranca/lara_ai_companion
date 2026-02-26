import 'package:firebase_auth/firebase_auth.dart';

import '../../domain/data/data_sources/create_account_firebase_data_source.dart';

final class CreateAccountFirebaseDataSourceImpl
    implements CreateAccountFirebaseDataSource {
  CreateAccountFirebaseDataSourceImpl(this._firebaseAuth);

  final FirebaseAuth _firebaseAuth;

  @override
  Future<User?> create({
    required String name,
    required String email,
    required String password,
  }) async {
    final credential = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    return credential.user!;
  }
}
