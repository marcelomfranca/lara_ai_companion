// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_list_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ChatListController)
final chatListControllerProvider = ChatListControllerProvider._();

final class ChatListControllerProvider
    extends $AsyncNotifierProvider<ChatListController, List<Chat>> {
  ChatListControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'chatListControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$chatListControllerHash();

  @$internal
  @override
  ChatListController create() => ChatListController();
}

String _$chatListControllerHash() =>
    r'0f72381d651647bb9a032ae70e1238aa00d66046';

abstract class _$ChatListController extends $AsyncNotifier<List<Chat>> {
  FutureOr<List<Chat>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<Chat>>, List<Chat>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<Chat>>, List<Chat>>,
              AsyncValue<List<Chat>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(ChatListActionsController)
final chatListActionsControllerProvider = ChatListActionsControllerProvider._();

final class ChatListActionsControllerProvider
    extends $AsyncNotifierProvider<ChatListActionsController, void> {
  ChatListActionsControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'chatListActionsControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$chatListActionsControllerHash();

  @$internal
  @override
  ChatListActionsController create() => ChatListActionsController();
}

String _$chatListActionsControllerHash() =>
    r'988d9e15824cdedf2b585f0931c83d10b0cc7617';

abstract class _$ChatListActionsController extends $AsyncNotifier<void> {
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
