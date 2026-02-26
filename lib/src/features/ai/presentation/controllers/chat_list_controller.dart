import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/application/extensions/async_loading_extension.dart';

import '../../application/providers/chat_repository_provider.dart';
import '../../domain/entities/chat.dart';

part 'chat_list_controller.g.dart';

@riverpod
class ChatListController extends _$ChatListController {
  late final _repository = ref.watch(chatRepositoryProvider);

  @override
  FutureOr<List<Chat>> build() => _repository.getAll();

  Future<void> getChats() async {
    state = await AsyncValue.guard(() => _repository.getAll());
  }

  Future<void> delete({List<int>? indexList, bool? all}) async {
    final chatListController = ref.read(
      chatListActionsControllerProvider.notifier,
    );

    if (all == true) {
      state = AsyncValue.data([]);
    }

    if (indexList != null) {
      final idsToRemove = indexList.toSet();

      state = state.whenData(
        (items) =>
            items.where((item) => !idsToRemove.contains(item.id)).toList(),
      );
    }

    try {
      await chatListController.delete(indexList: indexList, all: all);
    } catch (_) {}
  }
}

@riverpod
class ChatListActionsController extends _$ChatListActionsController {
  late final _repository = ref.watch(chatRepositoryProvider);

  @override
  FutureOr<void> build() {}

  Future<void> delete({List<int>? indexList, bool? all}) async {
    assert(
      (indexList != null && indexList.isNotEmpty) || (all == true),
      'Either indexList must have values OR all must be true.',
    );

    state = state.withSmartLoading();

    try {
      await _repository.delete(indexList ?? [], all);

      state = AsyncValue.data(null);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }

    state.dismissLoadingOnResult();
  }
}
