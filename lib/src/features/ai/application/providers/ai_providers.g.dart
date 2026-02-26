// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ai_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(geminiModel)
final geminiModelProvider = GeminiModelProvider._();

final class GeminiModelProvider
    extends
        $FunctionalProvider<GenerativeModel, GenerativeModel, GenerativeModel>
    with $Provider<GenerativeModel> {
  GeminiModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'geminiModelProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$geminiModelHash();

  @$internal
  @override
  $ProviderElement<GenerativeModel> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  GenerativeModel create(Ref ref) {
    return geminiModel(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GenerativeModel value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GenerativeModel>(value),
    );
  }
}

String _$geminiModelHash() => r'29fb6f535136d67ee1d65057732702c26c82be1c';
