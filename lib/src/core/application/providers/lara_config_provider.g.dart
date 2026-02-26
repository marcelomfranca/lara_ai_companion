// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lara_config_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(laraConfigRepository)
final laraConfigRepositoryProvider = LaraConfigRepositoryProvider._();

final class LaraConfigRepositoryProvider
    extends
        $FunctionalProvider<
          LaraConfigRepository,
          LaraConfigRepository,
          LaraConfigRepository
        >
    with $Provider<LaraConfigRepository> {
  LaraConfigRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'laraConfigRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$laraConfigRepositoryHash();

  @$internal
  @override
  $ProviderElement<LaraConfigRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  LaraConfigRepository create(Ref ref) {
    return laraConfigRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LaraConfigRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LaraConfigRepository>(value),
    );
  }
}

String _$laraConfigRepositoryHash() =>
    r'701523470e9e5e950aa4db2e68042ad1dd7fe093';
