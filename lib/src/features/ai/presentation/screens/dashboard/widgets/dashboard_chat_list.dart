import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../../../core/application/extensions/async_value_extension.dart';
import '../../../../../../core/application/extensions/hardcoded_string_extension.dart';
import '../../../../../../core/application/extensions/theme_build_context_extension.dart';
import '../../../../../../core/presentation/widgets/spinkit_three_bounce.dart';
import '../../../controllers/chat_list_controller.dart';
import 'chat_item_card.dart';
import 'empty_state_widget.dart';

class DashboardChatList extends ConsumerStatefulWidget {
  const DashboardChatList({super.key});

  @override
  ConsumerState<DashboardChatList> createState() =>
      _DashboardChatListConsumerState();
}

class _DashboardChatListConsumerState extends ConsumerState<DashboardChatList>
    with AutomaticKeepAliveClientMixin {
  final _refreshController = RefreshController(initialRefresh: false);
  final _scrollController = ScrollController();
  var _showFloating = false;
  final List<int> _selectedCards = [];

  @override
  bool get wantKeepAlive => true;

  Future<void> _onRefresh() async {
    final controller = ref.read(chatListControllerProvider.notifier);

    controller.getChats();

    _refreshController.refreshCompleted();
  }

  void clear() {
    _selectedCards.clear();
    _showFloating = _selectedCards.isNotEmpty;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    ref.listen<AsyncValue<void>>(
      chatListActionsControllerProvider,
      (_, state) => state.showSnackBarOnError(context),
    );

    final size = MediaQuery.of(context).size.width;

    final chatListState = ref.watch(chatListControllerProvider);

    return SmartRefresher(
      key: const ValueKey('dashboard_chatList'),
      enablePullDown: true,
      controller: _refreshController,
      onRefresh: _onRefresh,
      child: chatListState.when(
        data: (items) {
          log('$items');

          if (items.isEmpty) {
            return Center(
              child: ListView(
                shrinkWrap: true,
                physics: const AlwaysScrollableScrollPhysics(),
                children: <Widget>[
                  EmptyStateWidget(
                    onActionPressed: () {
                      ref.read(chatListControllerProvider.notifier).getChats();
                    },
                  ),
                ],
              ),
            );
          }

          return CustomScrollView(
            controller: _scrollController,
            restorationId: 'chatList'.hardcoded,
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: <Widget>[
              if (_showFloating) ...[
                SliverPersistentHeader(
                  floating: true,
                  delegate: _FloatingHeaderDelegate(
                    visible: _showFloating,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        IconButton(
                          onPressed: () {
                            ref
                                .read(chatListControllerProvider.notifier)
                                .delete(indexList: _selectedCards);

                            clear();
                          },
                          icon: Icon(Icons.delete_outline),
                        ),
                        IconButton(
                          onPressed: clear,
                          icon: Icon(Icons.deselect_outlined),
                        ),
                        IconButton(
                          onPressed: () {
                            ref
                                .read(chatListControllerProvider.notifier)
                                .delete(all: true);

                            clear();
                          },
                          icon: Icon(Icons.delete_sweep_outlined),
                        ),
                      ],
                    ),
                  ),
                ),
              ],

              SliverPadding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                sliver: SliverList.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    log(':::index: $index');

                    final item = items[index];

                    return ChatCard(
                      key: ValueKey(item.uid),
                      chat: item,
                      index: index,
                      selected:
                          (_selectedCards.indexWhere(
                            (value) => (value == item.id),
                          ) !=
                          -1),
                      onTap: () async {
                        await context.push('/chat/${item.uid}');

                        ref
                            .read(chatListControllerProvider.notifier)
                            .getChats();
                      },
                      onLongPress: (isSelected) {
                        setState(() {
                          if (isSelected) {
                            _selectedCards.add(item.id!);
                          } else {
                            _selectedCards.removeWhere(
                              (value) => (value == item.id),
                            );
                          }

                          _showFloating = _selectedCards.isNotEmpty;

                          log(':::selectedList: $_selectedCards');
                        });
                      },
                    );
                  },
                ),
              ),
            ],
          );
        },

        loading: () => Center(
          child: SpinKitThreeBounce(
            color: context.colors.primary,
            size: size * 0.05,
          ),
        ),
        error: (error, stackTrace) => const SizedBox(),
      ),
    );
  }
}

class _FloatingHeaderDelegate extends SliverPersistentHeaderDelegate {
  _FloatingHeaderDelegate({required this.visible, required this.child});

  final bool visible;
  final Widget child;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      color: context.colors.indigo.withValues(alpha: 0.3),
      alignment: Alignment.center,
      child: child,
    );
  }

  @override
  double get maxExtent => 60;

  @override
  double get minExtent => 60;

  @override
  bool shouldRebuild(covariant _FloatingHeaderDelegate oldDelegate) {
    return oldDelegate.visible != visible;
  }
}
