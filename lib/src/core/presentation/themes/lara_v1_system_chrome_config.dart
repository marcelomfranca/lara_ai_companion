import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../domain/theme/app_theme.dart';

final class LaraV1SystemChromeConfig implements AppSystemChromeConfig {
  @override
  SystemUiMode get systemUiMode => SystemUiMode.edgeToEdge;

  @override
  List<SystemUiOverlay>? get systemUiOverlay => [SystemUiOverlay.top];

  @override
  SystemUiOverlayStyle get systemUiOverlayStyleDarkMode =>
      const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarDividerColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.light,
        systemNavigationBarContrastEnforced: false,
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.light,
      );

  @override
  SystemUiOverlayStyle get systemUiOverlayStyleLightMode =>
      const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarDividerColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.dark,
        systemNavigationBarContrastEnforced: false,
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.dark,
      );
}
