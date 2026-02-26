import 'dart:async';
import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'firebase_options.dart';
import 'src/app/app.dart' as lara;
import 'src/core/application/observers/riverpod_observer.dart';
import 'src/core/domain/configs/app_config.dart';
import 'src/core/presentation/themes/lara_v1_system_chrome_config.dart';

void main() async {
  log('Environment: ${AppConfig.environment.name}');

  await runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      // Configure SO ui style
      final systemChromeConfig = LaraV1SystemChromeConfig();

      SystemChrome.setSystemUIOverlayStyle(
        systemChromeConfig.systemUiOverlayStyleDarkMode,
      );

      SystemChrome.setEnabledSystemUIMode(
        systemChromeConfig.systemUiMode,
        overlays: systemChromeConfig.systemUiOverlay,
      );

      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );

      // handler for flutter sdk errors
      FlutterError.onError = (FlutterErrorDetails details) {
        FirebaseCrashlytics.instance.recordFlutterFatalError(details);
      };

      //handler for platform errors
      PlatformDispatcher.instance.onError = (error, stack) {
        FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
        return true;
      };

      runApp(
        const ProviderScope(observers: [RiverpodObserver()], child: lara.App()),
      );
    },
    (Object error, StackTrace stack) {
      log(error.toString(), stackTrace: stack);

      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    },
  );
}
