import 'package:flutter/material.dart';
import '../../application/providers/app_settings_providers.dart';
import '../themes/lara_v1_theme.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/theme/app_theme.dart';

part 'theme_controller.g.dart';

typedef ThemeState = ({ThemeMode mode, AppTheme selected});

@riverpod
class ThemeController extends _$ThemeController {
  late final _repository = ref.read(appSettingsRepositoryProvider);
  late ThemeState themeState;

  @override
  FutureOr<ThemeState> build() {
    themeState = (mode: ThemeMode.light, selected: LaraV1Theme());

    return themeState;
  }

  Future<void> load() async {
    try {
      final mode = await _repository.getThemeModeSetting();

      themeState = (mode: ThemeMode.values[mode], selected: LaraV1Theme());

      state = AsyncValue.data(themeState);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }

    if (state.hasValue) themeState = state.value!;
  }

  Future<void> toggleThemeMode([bool? value]) async {
    late ThemeMode currentMode;

    if (value != null) {
      currentMode = value ? ThemeMode.dark : ThemeMode.light;
    } else {
      currentMode = (themeState.mode == ThemeMode.light)
          ? ThemeMode.dark
          : ThemeMode.light;
    }

    themeState = (mode: currentMode, selected: LaraV1Theme());

    state = AsyncData((mode: currentMode, selected: themeState.selected));

    await _repository.updateThemeModeSetting(currentMode.index);
  }
}
