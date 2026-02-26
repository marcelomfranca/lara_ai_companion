// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'load_app_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(LoadAppController)
final loadAppControllerProvider = LoadAppControllerProvider._();

final class LoadAppControllerProvider
    extends $AsyncNotifierProvider<LoadAppController, bool> {
  LoadAppControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'loadAppControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$loadAppControllerHash();

  @$internal
  @override
  LoadAppController create() => LoadAppController();
}

String _$loadAppControllerHash() => r'e6bca09582db66fd5c5dada74344125da06725db';

abstract class _$LoadAppController extends $AsyncNotifier<bool> {
  FutureOr<bool> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<bool>, bool>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<bool>, bool>,
              AsyncValue<bool>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
