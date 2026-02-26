import '../../entities/lara_config.dart';

abstract interface class SetLaraConfigDataSource {
  Future<void> set(LaraConfig config);
}
