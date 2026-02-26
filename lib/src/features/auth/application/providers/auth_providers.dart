import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/data_sources/create_account_firebase_data_source_impl.dart';
import '../../data/data_sources/signin_firebase_data_source_impl.dart';
import '../../data/data_sources/signin_google_firebase_data_source_impl.dart';
import '../../data/data_sources/signout_firebase_data_source_impl.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../domain/data/repositories/auth_repository.dart';

part 'auth_providers.g.dart';

@Riverpod(keepAlive: true)
FirebaseAuth firebaseAuth(Ref ref) => FirebaseAuth.instance;

@Riverpod(keepAlive: true)
GoogleSignIn googleSignIn(Ref ref) => GoogleSignIn.instance;

@Riverpod(keepAlive: true)
AuthRepository authRepository(Ref ref) {
  final firebaseAuth = ref.watch(firebaseAuthProvider);
  final googleSignIn = ref.watch(googleSignInProvider);

  return AuthRepositoryImpl(
    SignInFirebaseDataSourceImpl(firebaseAuth),
    SignInWithGoogleFirebaseDataSourceImpl(firebaseAuth, googleSignIn),
    SignOutFirebaseDataSourceImpl(firebaseAuth),
    CreateAccountFirebaseDataSourceImpl(firebaseAuth),
  );
}
