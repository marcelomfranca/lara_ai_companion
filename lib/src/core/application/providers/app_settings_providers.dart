import 'shared_preferences_provider.dart';
import '../../data/data_sources/get_theme_mode_setting_data_source_impl.dart';
import '../../data/data_sources/update_theme_mode_setting_data_source_impl.dart';
import '../../data/repositories/app_settings_repository_impl.dart';
import '../../domain/data/repositories/app_settings_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_settings_providers.g.dart';

@Riverpod(keepAlive: true)
AppSettingsRepository appSettingsRepository(Ref ref) {
  final prefs = ref.watch(sharedPreferencesProvider);

  return AppSettingsRepositoryImpl(
    GetThemeSettingDataSourceImpl(prefs),
    UpdateThemeSettingDataSourceImpl(prefs),
  );
}
