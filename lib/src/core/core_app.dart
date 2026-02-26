import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'application/extensions/hardcoded_string_extension.dart';
import 'core_module.dart';
import '../features/auth/auth_module.dart';
import '../features/ai/ai_module.dart';

final class CoreApp {
  CoreApp._();

  static final CoreApp instance = CoreApp._();

  static final navigatorKey = GlobalKey<NavigatorState>();

  static final modules = [CoreModule(), AuthModule(), AiModule()];

  static const routerRestorationScopeId = 'laraAI_goRouter';

  static const initialLocation = '/splash';

  static const geminiApiKey = '';

  static const googleServerClientId = '';

  Future<void> initialize() async {
    // Initialize Singletons
    log('Initialize Singletons'.hardcoded);
    await _initializeSingletons();
  }

  Future<void> _initializeSingletons() async {
    // await LocalSettingsController.instance.initialize();
  }
}
