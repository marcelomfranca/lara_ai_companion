// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signin_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SigninController)
final signinControllerProvider = SigninControllerProvider._();

final class SigninControllerProvider
    extends $AsyncNotifierProvider<SigninController, void> {
  SigninControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'signinControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$signinControllerHash();

  @$internal
  @override
  SigninController create() => SigninController();
}

String _$signinControllerHash() => r'b3f3d51f97676a524fdd78af4d6af4888913c69b';

abstract class _$SigninController extends $AsyncNotifier<void> {
  FutureOr<void> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<void>, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<void>, void>,
              AsyncValue<void>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
