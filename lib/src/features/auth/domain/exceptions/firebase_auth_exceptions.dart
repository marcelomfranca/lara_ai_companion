// lib/core/error/auth_exceptions.dart

import 'package:flutter/foundation.dart';
import 'package:lara_ai/src/core/application/extensions/hardcoded_string_extension.dart';
import 'package:lara_ai/src/core/domain/exceptions/app_exception.dart';

sealed class FirebaseAuthException extends AppException {
  const FirebaseAuthException(super.message, {super.stackTrace});

  factory FirebaseAuthException.fromCode(
    String code, [
    StackTrace? stackTrace,
  ]) {
    return switch (code) {
      'email-already-in-use' => EmailAlreadyInUseException(stackTrace),
      'invalid-credential' => InvalidCredentialException(stackTrace),
      'invalid-email' => InvalidEmailException(stackTrace),
      'user-disabled' => UserDisabledException(stackTrace),
      'user-not-found' => UserNotFoundException(stackTrace),
      'wrong-password' => WrongPasswordException(stackTrace),
      'too-many-requests' => TooManyRequestsException(stackTrace),
      'requires-recent-login' => RequiresRecentLoginException(stackTrace),
      // Google Sign-In Codes (Mapeados como String)
      'canceled' => AuthCanceledException(stackTrace),
      'interrupted' => AuthInterruptedException(stackTrace),
      'client-configuration-error' => ClientConfigurationException(stackTrace),
      'provider-configuration-error' => ProviderConfigurationException(
        stackTrace,
      ),
      'ui-unavailable' => UiUnavailableException(stackTrace),
      'user-mismatch' => UserMismatchException(stackTrace),
      _ => UnknownAuthException(stackTrace),
    };
  }
}

@immutable
final class EmailAlreadyInUseException extends FirebaseAuthException {
  EmailAlreadyInUseException([StackTrace? stackTrace])
    : super(
        'The email address is already in use by another account.'.hardcoded,
        stackTrace: stackTrace,
      );
}

@immutable
final class InvalidEmailException extends FirebaseAuthException {
  InvalidEmailException([StackTrace? stackTrace])
    : super(
        'The email address is badly formatted.'.hardcoded,
        stackTrace: stackTrace,
      );
}

@immutable
final class InvalidCredentialException extends FirebaseAuthException {
  InvalidCredentialException([StackTrace? stackTrace])
    : super(
        'User not found or wrong password. If you don`t have an account click on Sign up.'
            .hardcoded,
        stackTrace: stackTrace,
      );
}

@immutable
final class UserDisabledException extends FirebaseAuthException {
  UserDisabledException([StackTrace? stackTrace])
    : super(
        'This user has been disabled. Please contact support.'.hardcoded,
        stackTrace: stackTrace,
      );
}

@immutable
final class UserNotFoundException extends FirebaseAuthException {
  UserNotFoundException([StackTrace? stackTrace])
    : super('No user found with this email.'.hardcoded, stackTrace: stackTrace);
}

@immutable
final class WrongPasswordException extends FirebaseAuthException {
  WrongPasswordException([StackTrace? stackTrace])
    : super(
        'The password is invalid or the user does not have a password.'
            .hardcoded,
        stackTrace: stackTrace,
      );
}

@immutable
final class TooManyRequestsException extends FirebaseAuthException {
  TooManyRequestsException([StackTrace? stackTrace])
    : super(
        'Too many unsuccessful login attempts. Please try again later.'
            .hardcoded,
        stackTrace: stackTrace,
      );
}

@immutable
final class RequiresRecentLoginException extends FirebaseAuthException {
  RequiresRecentLoginException([StackTrace? stackTrace])
    : super(
        'This operation is sensitive and requires recent authentication. Log in again before retrying this request.'
            .hardcoded,
        stackTrace: stackTrace,
      );
}

@immutable
final class UnknownAuthException extends FirebaseAuthException {
  UnknownAuthException([StackTrace? stackTrace])
    : super(
        'An unknown authentication error occurred.'.hardcoded,
        stackTrace: stackTrace,
      );
}

@immutable
final class AuthCanceledException extends FirebaseAuthException {
  AuthCanceledException([StackTrace? stackTrace])
    : super('Sign-in canceled.'.hardcoded, stackTrace: stackTrace);
}

@immutable
final class AuthInterruptedException extends FirebaseAuthException {
  AuthInterruptedException([StackTrace? stackTrace])
    : super('Connection interrupted.'.hardcoded, stackTrace: stackTrace);
}

@immutable
final class ClientConfigurationException extends FirebaseAuthException {
  ClientConfigurationException([StackTrace? stackTrace])
    : super('App setup error.'.hardcoded, stackTrace: stackTrace);
}

@immutable
final class ProviderConfigurationException extends FirebaseAuthException {
  ProviderConfigurationException([StackTrace? stackTrace])
    : super('Service unavailable.'.hardcoded, stackTrace: stackTrace);
}

@immutable
final class UiUnavailableException extends FirebaseAuthException {
  UiUnavailableException([StackTrace? stackTrace])
    : super('Screen not ready.'.hardcoded, stackTrace: stackTrace);
}

@immutable
final class UserMismatchException extends FirebaseAuthException {
  UserMismatchException([StackTrace? stackTrace])
    : super('Account mismatch.'.hardcoded, stackTrace: stackTrace);
}
