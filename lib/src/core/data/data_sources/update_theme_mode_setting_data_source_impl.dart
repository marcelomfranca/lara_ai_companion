import '../../domain/data/data_sources/update_theme_mode_setting_data_source.dart';
import 'package:shared_preferences/shared_preferences.dart';

final class UpdateThemeSettingDataSourceImpl
    implements UpdateThemeSettingDataSource {
  UpdateThemeSettingDataSourceImpl(this._prefs);

  final SharedPreferencesAsync _prefs;

  @override
  Future<void> update(int mode) async {
    await _prefs.setInt('app_settings_theme_mode', mode);
  }
}
