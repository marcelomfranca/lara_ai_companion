// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_database_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ChatDatabaseController)
final chatDatabaseControllerProvider = ChatDatabaseControllerFamily._();

final class ChatDatabaseControllerProvider
    extends $NotifierProvider<ChatDatabaseController, void> {
  ChatDatabaseControllerProvider._({
    required ChatDatabaseControllerFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'chatDatabaseControllerProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$chatDatabaseControllerHash();

  @override
  String toString() {
    return r'chatDatabaseControllerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  ChatDatabaseController create() => ChatDatabaseController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(void value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<void>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is ChatDatabaseControllerProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$chatDatabaseControllerHash() =>
    r'6ee4c9e730c0d9159c70a098d70f62e5be59711d';

final class ChatDatabaseControllerFamily extends $Family
    with
        $ClassFamilyOverride<ChatDatabaseController, void, void, void, String> {
  ChatDatabaseControllerFamily._()
    : super(
        retry: null,
        name: r'chatDatabaseControllerProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ChatDatabaseControllerProvider call(String chatUid) =>
      ChatDatabaseControllerProvider._(argument: chatUid, from: this);

  @override
  String toString() => r'chatDatabaseControllerProvider';
}

abstract class _$ChatDatabaseController extends $Notifier<void> {
  late final _$args = ref.$arg as String;
  String get chatUid => _$args;

  void build(String chatUid);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<void, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<void, void>,
              void,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
}
