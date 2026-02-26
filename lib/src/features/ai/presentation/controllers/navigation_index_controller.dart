import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'navigation_index_controller.g.dart';

@riverpod
class NavigationIndexController extends _$NavigationIndexController {
  @override
  int build() => 0;

  void setIndex(int index) => state = index;
}
