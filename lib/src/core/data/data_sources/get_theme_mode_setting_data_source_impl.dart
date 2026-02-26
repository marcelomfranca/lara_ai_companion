import '../../domain/data/data_sources/get_theme_mode_setting_data_source.dart';
import 'package:shared_preferences/shared_preferences.dart';

final class GetThemeSettingDataSourceImpl implements GetThemeSettingDataSource {
  GetThemeSettingDataSourceImpl(this._prefs);

  final SharedPreferencesAsync _prefs;

  @override
  Future<int> get() async =>
      await _prefs.getInt('app_settings_theme_mode') ?? 1;
}
