import '../../domain/data/data_sources/get_lara_config_data_source.dart';
import 'package:shared_preferences/shared_preferences.dart';

final class GetLaraConfigDataSourceImpl implements GetLaraConfigDataSource {
  GetLaraConfigDataSourceImpl(this._prefs);

  final SharedPreferencesAsync _prefs;

  @override
  Future<
    ({
      double? humorLevel,
      double? personalityTone,
      String? language,
      int? responseLength,
    })
  >
  get() async {
    final humor = await _prefs.getDouble('lara_config_humor_level');
    final personalityTone = await _prefs.getDouble(
      'lara_config_personality_tone',
    );
    final language = await _prefs.getString('lara_config_language');
    final responseLength = await _prefs.getInt('lara_config_response_length');

    return (
      humorLevel: humor,
      personalityTone: personalityTone,
      language: language,
      responseLength: responseLength,
    );
  }
}
