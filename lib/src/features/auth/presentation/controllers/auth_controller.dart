import '../../../../core/application/extensions/async_loading_extension.dart';
import '../../../../core/domain/entities/lara_user.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../application/providers/auth_providers.dart';
import '../../data/models/user_model.dart';

part 'auth_controller.g.dart';

@Riverpod(keepAlive: true)
Stream<LaraUser?> authStateChanges(Ref ref) {
  final firebaseAuth = ref.watch(firebaseAuthProvider);

  return firebaseAuth.authStateChanges().map((user) {
    if (user == null) return null;
    return UserModel.fromFirebase(user).toEntity();
  });
}

@Riverpod(keepAlive: true)
class AuthController extends _$AuthController {
  late final _repository = ref.read(authRepositoryProvider);

  @override
  AsyncValue<LaraUser?> build() {
    return ref.watch(authStateChangesProvider);
  }

  Future<void> signInWithEmail({
    required String email,
    required String password,
  }) async {
    state = state.withSmartLoading();

    state = await AsyncValue.guard(
      () => _repository.signInWithEmail(email, password),
    );

    state.dismissLoadingOnResult();
  }

  Future<void> signInWithGoogle() async {
    state = state.withSmartLoading();

    state = await AsyncValue.guard(() => _repository.signInWithGoogle());

    state.dismissLoadingOnResult();
  }

  Future<void> signOut() async {
    state = state.withSmartLoading();

    state = await AsyncValue.guard(() async {
      await _repository.signOut();

      return null;
    });

    state.dismissLoadingOnResult();
  }

  Future<void> createAccount(String name, String email, String password) async {
    state = state.withSmartLoading();

    state = await AsyncValue.guard(
      () => _repository.createAccount(name, email, password),
    );

    state.dismissLoadingOnResult();
  }

  Future<void> refreshSession() async {
    final user = ref.read(firebaseAuthProvider).currentUser;
    try {
      await user?.getIdToken(true);
    } catch (e) {
      await signOut();
    }
  }
}
