import '../enums/environment_enum.dart';

abstract class AppConfig {
  static const appName = 'LARA - AI Companion';
  static const environment = EnvironmentEnum.dev;
  static bool get isProduction => (environment == EnvironmentEnum.prod);
  static const restorationScopeId = 'laraAI_app_v1';
}
