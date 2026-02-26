import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../domain/data/data_sources/signin_google_firebase_data_source.dart';

final class SignInWithGoogleFirebaseDataSourceImpl
    implements SignInWithGoogleFirebaseDataSource {
  SignInWithGoogleFirebaseDataSourceImpl(
    this._firebaseAuth,
    this._googleSignIn,
  );

  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  @override
  Future<User?> signIn() async {
    final googleUser = await _googleSignIn.authenticate();
    final googleAuth = googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      idToken: googleAuth.idToken,
    );
    final userCredential = await _firebaseAuth.signInWithCredential(credential);

    return userCredential.user;
  }
}
