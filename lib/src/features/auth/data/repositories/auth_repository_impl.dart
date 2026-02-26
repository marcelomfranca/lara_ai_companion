import 'package:google_sign_in/google_sign_in.dart';
import '../../../../core/domain/entities/lara_user.dart';
import '../../../../core/domain/exceptions/app_exception.dart';
import '../models/user_model.dart';
import '../../domain/data/data_sources/create_account_firebase_data_source.dart';
import '../../domain/data/data_sources/signin_firebase_data_source.dart';
import '../../domain/data/data_sources/signin_google_firebase_data_source.dart';
import '../../domain/data/data_sources/signout_firebase_data_source.dart';
import '../../domain/data/repositories/auth_repository.dart';
import '../../domain/exceptions/firebase_auth_exceptions.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;

final class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(
    this._signInFirebaseDataSource,
    this._signInWithGoogleFirebaseDataSource,
    this._signOutFirebaseDataSource,
    this._createAccountFirebaseDataSource,
  );

  final SignInFirebaseDataSource _signInFirebaseDataSource;
  final SignInWithGoogleFirebaseDataSource _signInWithGoogleFirebaseDataSource;
  final SignOutFirebaseDataSource _signOutFirebaseDataSource;
  final CreateAccountFirebaseDataSource _createAccountFirebaseDataSource;

  @override
  Future<LaraUser> signInWithEmail(String email, String password) async {
    try {
      final user = await _signInFirebaseDataSource.signIn(
        email: email,
        password: password,
      );

      if (user == null) throw UnknownAuthException();

      return UserModel.fromFirebase(user).toEntity();
    } on fb.FirebaseAuthException catch (e) {
      throw FirebaseAuthException.fromCode(e.code);
    } on FirebaseAuthException catch (_) {
      rethrow;
    } catch (error, stackTrace) {
      throw AppException(error.toString(), stackTrace: stackTrace);
    }
  }

  @override
  Future<void> signOut() async {
    try {
      _signOutFirebaseDataSource.signOut();
    } on fb.FirebaseAuthException catch (e) {
      throw FirebaseAuthException.fromCode(e.code);
    } catch (error, stackTrace) {
      throw AppException(error.toString(), stackTrace: stackTrace);
    }
  }

  @override
  Future<LaraUser> createAccount(
    String name,
    String email,
    String password,
  ) async {
    try {
      final user = await _createAccountFirebaseDataSource.create(
        name: name,
        email: email,
        password: password,
      );

      if (user == null) throw UnknownAuthException();

      await user.updateDisplayName(name);

      await user.reload();

      return UserModel.fromFirebase(user, name).toEntity();
    } on fb.FirebaseAuthException catch (e) {
      throw FirebaseAuthException.fromCode(e.code);
    } on FirebaseAuthException catch (_) {
      rethrow;
    } catch (error, stackTrace) {
      throw AppException(error.toString(), stackTrace: stackTrace);
    }
  }

  @override
  Future<LaraUser> signInWithGoogle() async {
    try {
      final user = await _signInWithGoogleFirebaseDataSource.signIn();

      if (user == null) throw UnknownAuthException();

      return UserModel.fromFirebase(user).toEntity();
    } on GoogleSignInException catch (e) {
      throw FirebaseAuthException.fromCode(e.code.name);
    } catch (error, stackTrace) {
      throw AppException(error.toString(), stackTrace: stackTrace);
    }
  }
}
