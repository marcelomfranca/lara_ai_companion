import 'dart:developer';

import 'lara_config_controller.dart';
import '../providers/sqflite_provider.dart';
import '../../core_app.dart';
import '../../presentation/controllers/theme_controller.dart';
import '../../../features/auth/application/providers/auth_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'load_app_controller.g.dart';

@Riverpod(keepAlive: true)
class LoadAppController extends _$LoadAppController {
  @override
  FutureOr<bool> build() {
    loadApp();

    return false;
  }

  Future<void> loadApp() async {
    state = const AsyncLoading();

    try {
      final stopwatch = Stopwatch()..start();

      await Future.wait([
        _initializeFirebase(),
        _initializeGoogleSignInAuth(),
        _initializeAuth(),
        _initializeConfig(),
        _initializeSqflite(),
        _loadThemeSettings(),
      ]);

      final elapsed = stopwatch.elapsedMilliseconds;
      const minimumDisplayTime = 6000;

      if (elapsed < minimumDisplayTime) {
        await Future.delayed(
          Duration(milliseconds: minimumDisplayTime - elapsed),
        );
      }

      stopwatch.stop();

      log('loadingAppTime: ${elapsed + (minimumDisplayTime - elapsed)}');

      state = AsyncValue.data(true);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> _initializeFirebase() async {
    // await Firebase.initializeApp(
    //   options: DefaultFirebaseOptions.currentPlatform,
    // );
  }

  Future<void> _initializeGoogleSignInAuth() async {
    final google = ref.read(googleSignInProvider);
    google.initialize(serverClientId: CoreApp.googleServerClientId);
  }

  Future<void> _initializeAuth() async {
    final auth = ref.read(firebaseAuthProvider);
    final user = await auth.authStateChanges().first;

    if (user != null) {
      try {
        await user.getIdToken(true);
      } catch (e) {
        await auth.signOut();
      }
    }
  }

  Future<void> _initializeConfig() async => await ref
      .read(laraConfigControllerProvider.notifier)
      .loadConfig()
      .then((_) => log('Config loaded'));

  Future<void> _initializeSqflite() async => await ref
      .read(sqfliteProvider.future)
      .then((_) => log('Sqflite initialized'));

  Future<void> _loadThemeSettings() async => await ref
      .read(themeControllerProvider.notifier)
      .load()
      .then((_) => log('Theme settings loaded'));
}
