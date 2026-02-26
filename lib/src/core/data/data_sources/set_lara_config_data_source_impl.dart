import '../../domain/data/data_sources/set_lara_config_data_source.dart';
import '../../domain/entities/lara_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

final class SetLaraConfigDataSourceImpl implements SetLaraConfigDataSource {
  SetLaraConfigDataSourceImpl(this._prefs);

  final SharedPreferencesAsync _prefs;

  @override
  Future<void> set(LaraConfig config) async {
    await _prefs.setDouble('lara_config_humor_level', config.humorLevel);
    await _prefs.setDouble(
      'lara_config_personality_tone',
      config.personalityTone,
    );
    await _prefs.setString('lara_config_language', config.language);
    await _prefs.setInt(
      'lara_config_response_length',
      config.responseLength.index,
    );
  }
}
