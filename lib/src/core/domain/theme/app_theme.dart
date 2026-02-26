import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

@immutable
abstract interface class AppTheme {
  static const double defaultRadius = 16.0;

  bool get useMaterial3;
  AppColors get colors;
  String get fontFamily;
  VisualDensity get visualDensity;
  ThemeData get lightThemeData;
  ThemeData get darkThemeData;
  AppTextStyles get textStyles;
  AppDecorations get decorations;
  AppSystemChromeConfig get systemChromeConfig;
}

@immutable
abstract interface class AppColors {
  Color get primary;
  Color get secondary;
  Color get tertiary;
  Color get white;
  Color get indigo;
  Color get digitalIndigo;
  Color get violet;
  Color get cyan;
  Color get red;
  Color get white50;
  Color get darkGrey;
  Color get blackShadow;
  Color get midnightAbyss;
  Color get vividOrchid;
  Color get electricCyan;
  Color get crimsonPulse;
  Color get pureMist;
  Color get charcoalSlate;
  Color get frostedGlass;
  Color get carbonNight;
  Color get luminousVeil;
  Color get etherealVoid;
  Color get titaniumEcho;
  Color get error;
  Color get hintText;
  Color get border;
}

@immutable
abstract interface class AppTextStyles {
  TextStyle get text10;
  TextStyle get text10w500;
  TextStyle get text12;
  TextStyle get text12w500;
  TextStyle get text12w600;
  TextStyle get text13;
  TextStyle get text13w500;
  TextStyle get text14;
  TextStyle get text14Bold;
  TextStyle get text14w400;
  TextStyle get text14w500;
  TextStyle get text14w600;
  TextStyle get text16;
  TextStyle get text16Bold;
  TextStyle get text16w500;
  TextStyle get text18;
  TextStyle get text18Bold;
  TextStyle get text20;
  TextStyle get text20Bold;
  TextStyle get text24;
  TextStyle get text24Bold;
  TextStyle get text24w700;
}

@immutable
abstract interface class AppDecorations {
  InputDecorationTheme get inputDecorationLightTheme;
  InputDecorationTheme get inputDecorationDarkTheme;
  InputDecoration get textField;
  BoxDecoration get linearDarkGradientDecoration;
  BoxDecoration get primaryButtonDecoration;
  BoxDecoration get secondaryTransparentButtonDecoration;
  BoxDecoration get tertiaryButtonDecoration;
  BoxDecoration get appBarGradient;
}

@immutable
abstract interface class AppSystemChromeConfig {
  SystemUiOverlayStyle get systemUiOverlayStyleDarkMode;
  SystemUiOverlayStyle get systemUiOverlayStyleLightMode;
  SystemUiMode get systemUiMode;
  List<SystemUiOverlay>? get systemUiOverlay;
}
