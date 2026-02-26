// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'navigation_index_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(NavigationIndexController)
final navigationIndexControllerProvider = NavigationIndexControllerProvider._();

final class NavigationIndexControllerProvider
    extends $NotifierProvider<NavigationIndexController, int> {
  NavigationIndexControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'navigationIndexControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$navigationIndexControllerHash();

  @$internal
  @override
  NavigationIndexController create() => NavigationIndexController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int>(value),
    );
  }
}

String _$navigationIndexControllerHash() =>
    r'29cc2ab378cc3c4ac4d3fb8ab1b8b7f273403eca';

abstract class _$NavigationIndexController extends $Notifier<int> {
  int build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<int, int>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<int, int>,
              int,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
