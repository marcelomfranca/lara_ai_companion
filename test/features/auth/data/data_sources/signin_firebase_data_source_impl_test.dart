// test/features/auth/data/datasources/sign_in_firebase_data_source_impl_test.dart

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lara_ai/src/features/auth/data/data_sources/signin_firebase_data_source_impl.dart';
import 'package:mocktail/mocktail.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockUserCredential extends Mock implements UserCredential {}

class MockUser extends Mock implements User {}

void main() {
  late MockFirebaseAuth mockFirebaseAuth;
  late MockUserCredential mockUserCredential;
  late MockUser mockUser;
  late SignInFirebaseDataSourceImpl dataSource;

  const tEmail = 'test@lara.ai';
  const tPassword = 'password123';

  setUp(() {
    mockFirebaseAuth = MockFirebaseAuth();
    mockUserCredential = MockUserCredential();
    mockUser = MockUser();
    dataSource = SignInFirebaseDataSourceImpl(mockFirebaseAuth);
  });

  group('signInWithEmailAndPassword', () {
    test('deve retornar um User quando o login for bem-sucedido', () async {
      when(() => mockUserCredential.user).thenReturn(mockUser);
      when(
        () => mockFirebaseAuth.signInWithEmailAndPassword(
          email: tEmail,
          password: tPassword,
        ),
      ).thenAnswer((_) async => mockUserCredential);

      final result = await dataSource.signIn(
        email: tEmail,
        password: tPassword,
      );

      expect(result, equals(mockUser));
      verify(
        () => mockFirebaseAuth.signInWithEmailAndPassword(
          email: tEmail,
          password: tPassword,
        ),
      ).called(1);
    });

    test(
      'deve lançar FirebaseAuthException quando o Firebase falhar',
      () async {
        // Arrange
        when(
          () => mockFirebaseAuth.signInWithEmailAndPassword(
            email: tEmail,
            password: tPassword,
          ),
        ).thenThrow(
          FirebaseAuthException(
            code: 'user-not-found',
            message: 'User not found',
          ),
        );

        expect(
          () => dataSource.signIn(email: tEmail, password: tPassword),
          throwsA(isA<FirebaseAuthException>()),
        );
      },
    );
  });
}
