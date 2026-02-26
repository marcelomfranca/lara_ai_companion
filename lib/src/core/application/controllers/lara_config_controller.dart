import '../providers/lara_config_provider.dart';
import '../../domain/entities/lara_config.dart';
import '../../../features/ai/domain/enums/ai_response_length_enum.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'lara_config_controller.g.dart';

@Riverpod(keepAlive: true)
class LaraConfigController extends _$LaraConfigController {
  late final _repository = ref.read(laraConfigRepositoryProvider);
  late LaraConfig laraConfig;

  @override
  FutureOr<LaraConfig> build() async {
    laraConfig = LaraConfig.initial();

    return laraConfig;
  }

  Future<void> loadConfig() async {
    state = await AsyncValue.guard(() => _repository.getLaraConfig());

    if (state.hasValue) laraConfig = state.value!;
  }

  Future<void> updateConfig({
    double? humorLevel,
    double? personalityTone,
    String? language,
    AiResponseLengthEnum? responseLength,
  }) async {
    var config = laraConfig.copyWith(
      humorLevel: humorLevel,
      personalityTone: personalityTone,
      language: language,
      responseLength: responseLength,
    );

    if (state.hasValue) {
      config = state.value!.copyWith(
        humorLevel: humorLevel,
        personalityTone: personalityTone,
        language: language,
        responseLength: responseLength,
      );

      state = AsyncData(config);
    }

    await _repository.updateLaraConfig(config);
  }
}
