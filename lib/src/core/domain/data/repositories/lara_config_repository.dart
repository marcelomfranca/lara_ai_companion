import '../../entities/lara_config.dart';

abstract interface class LaraConfigRepository {
  Future<LaraConfig> getLaraConfig();
  Future<void> updateLaraConfig(LaraConfig config);
}
