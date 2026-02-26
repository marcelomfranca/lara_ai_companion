import 'package:firebase_auth/firebase_auth.dart';
import '../../domain/data/data_sources/signout_firebase_data_source.dart';

final class SignOutFirebaseDataSourceImpl implements SignOutFirebaseDataSource {
  SignOutFirebaseDataSourceImpl(this._firebaseAuth);

  final FirebaseAuth _firebaseAuth;

  @override
  Future<void> signOut() => _firebaseAuth.signOut();
}
