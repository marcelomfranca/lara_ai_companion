import '../../domain/data/data_sources/get_theme_mode_setting_data_source.dart';
import '../../domain/data/data_sources/update_theme_mode_setting_data_source.dart';
import '../../domain/data/repositories/app_settings_repository.dart';
import '../../domain/exceptions/lara_config_exception.dart';

final class AppSettingsRepositoryImpl implements AppSettingsRepository {
  AppSettingsRepositoryImpl(
    this._getThemeSettingDataSource,
    this._updateThemeSettingDataSource,
  );

  final GetThemeSettingDataSource _getThemeSettingDataSource;
  final UpdateThemeSettingDataSource _updateThemeSettingDataSource;

  @override
  Future<int> getThemeModeSetting() async {
    try {
      return await _getThemeSettingDataSource.get();
    } catch (error, stackTrace) {
      throw LaraConfigException(error.toString(), stackTrace);
    }
  }

  @override
  Future<void> updateThemeModeSetting(int mode) async {
    try {
      await _updateThemeSettingDataSource.update(mode);
    } catch (error, stackTrace) {
      throw LaraConfigException(error.toString(), stackTrace);
    }
  }
}
