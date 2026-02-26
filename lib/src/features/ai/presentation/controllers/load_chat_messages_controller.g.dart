// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'load_chat_messages_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(LoadChatMessagesController)
final loadChatMessagesControllerProvider =
    LoadChatMessagesControllerProvider._();

final class LoadChatMessagesControllerProvider
    extends $AsyncNotifierProvider<LoadChatMessagesController, void> {
  LoadChatMessagesControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'loadChatMessagesControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$loadChatMessagesControllerHash();

  @$internal
  @override
  LoadChatMessagesController create() => LoadChatMessagesController();
}

String _$loadChatMessagesControllerHash() =>
    r'303e769481477a1520fbf9642e9c23ad1058aa35';

abstract class _$LoadChatMessagesController extends $AsyncNotifier<void> {
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
