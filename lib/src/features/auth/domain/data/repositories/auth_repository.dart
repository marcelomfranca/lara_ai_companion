// lib/features/auth/domain/repositories/auth_repository.dart
import 'package:lara_ai/src/core/domain/entities/lara_user.dart';

abstract interface class AuthRepository {
  Future<LaraUser> signInWithEmail(String email, String password);
  Future<LaraUser> signInWithGoogle();
  Future<void> signOut();
  Future<LaraUser> createAccount(String name, String email, String password);
}
