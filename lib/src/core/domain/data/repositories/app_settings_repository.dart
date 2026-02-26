abstract interface class AppSettingsRepository {
  Future<int> getThemeModeSetting();
  Future<void> updateThemeModeSetting(int mode);
}
