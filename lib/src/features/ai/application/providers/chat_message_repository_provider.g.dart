// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_message_repository_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(chatMessageRepository)
final chatMessageRepositoryProvider = ChatMessageRepositoryProvider._();

final class ChatMessageRepositoryProvider
    extends
        $FunctionalProvider<
          ChatMessageRepository,
          ChatMessageRepository,
          ChatMessageRepository
        >
    with $Provider<ChatMessageRepository> {
  ChatMessageRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'chatMessageRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$chatMessageRepositoryHash();

  @$internal
  @override
  $ProviderElement<ChatMessageRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ChatMessageRepository create(Ref ref) {
    return chatMessageRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ChatMessageRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ChatMessageRepository>(value),
    );
  }
}

String _$chatMessageRepositoryHash() =>
    r'7541b39ba4c25328158cf173af5c425c1b7563f4';
