// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lara_config_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(LaraConfigController)
final laraConfigControllerProvider = LaraConfigControllerProvider._();

final class LaraConfigControllerProvider
    extends $AsyncNotifierProvider<LaraConfigController, LaraConfig> {
  LaraConfigControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'laraConfigControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$laraConfigControllerHash();

  @$internal
  @override
  LaraConfigController create() => LaraConfigController();
}

String _$laraConfigControllerHash() =>
    r'8d915c3822c01b4f8d8eb6feab7a550da4ec86ae';

abstract class _$LaraConfigController extends $AsyncNotifier<LaraConfig> {
  FutureOr<LaraConfig> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<LaraConfig>, LaraConfig>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<LaraConfig>, LaraConfig>,
              AsyncValue<LaraConfig>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
