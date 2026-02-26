import '../../domain/data/data_sources/get_lara_config_data_source.dart';
import '../../domain/data/data_sources/set_lara_config_data_source.dart';
import '../../domain/data/repositories/lara_config_repository.dart';
import '../../domain/entities/lara_config.dart';
import '../../domain/exceptions/lara_config_exception.dart';
import '../../../features/ai/domain/enums/ai_response_length_enum.dart';

final class LaraConfigRepositoryImpl implements LaraConfigRepository {
  LaraConfigRepositoryImpl(
    this._getLaraConfigDataSource,
    this._setLaraConfigDataSource,
  );

  final GetLaraConfigDataSource _getLaraConfigDataSource;
  final SetLaraConfigDataSource _setLaraConfigDataSource;

  @override
  Future<LaraConfig> getLaraConfig() async {
    try {
      final record = await _getLaraConfigDataSource.get();
      final initial = LaraConfig.initial();

      return initial.copyWith(
        humorLevel: record.humorLevel,
        language: record.language,
        personalityTone: record.personalityTone,
        responseLength: AiResponseLengthEnum.values[record.responseLength ?? 2],
      );
    } catch (error, stackTrace) {
      throw LaraConfigException(error.toString(), stackTrace);
    }
  }

  @override
  Future<void> updateLaraConfig(LaraConfig config) async {
    try {
      await _setLaraConfigDataSource.set(config);
    } catch (error, stackTrace) {
      throw LaraConfigException(error.toString(), stackTrace);
    }
  }
}
