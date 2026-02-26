import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/data_sources/get_lara_config_data_source_impl.dart';
import '../../data/data_sources/set_lara_config_data_source_impl.dart';
import '../../data/repositories/lara_config_repository_impl.dart';
import '../../domain/data/repositories/lara_config_repository.dart';
import 'shared_preferences_provider.dart';

part 'lara_config_provider.g.dart';

@Riverpod(keepAlive: true)
LaraConfigRepository laraConfigRepository(Ref ref) {
  final prefs = ref.watch(sharedPreferencesProvider);

  return LaraConfigRepositoryImpl(
    GetLaraConfigDataSourceImpl(prefs),
    SetLaraConfigDataSourceImpl(prefs),
  );
}
