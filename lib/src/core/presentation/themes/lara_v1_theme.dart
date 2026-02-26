import 'package:flutter/material.dart';
import '../../domain/theme/app_theme.dart';
import 'lara_v1_colors.dart';
import 'lara_v1_decorations.dart';
import 'lara_v1_system_chrome_config.dart';
import 'lara_v1_text_styles.dart';

final class LaraV1Theme implements AppTheme {
  @override
  bool get useMaterial3 => true;

  @override
  String get fontFamily => 'Inter';

  @override
  VisualDensity get visualDensity => VisualDensity.adaptivePlatformDensity;

  @override
  AppColors get colors => LaraV1Colors();

  @override
  AppSystemChromeConfig get systemChromeConfig => LaraV1SystemChromeConfig();

  @override
  ThemeData get lightThemeData => ThemeData(
    useMaterial3: useMaterial3,
    brightness: Brightness.light,
    fontFamily: fontFamily,

    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: colors.primary,
      onPrimary: colors.white,
      secondary: colors.vividOrchid,
      onSecondary: colors.white,
      tertiary: colors.electricCyan,
      onTertiary: colors.white,
      error: colors.crimsonPulse,
      onError: colors.white,
      surface: colors.pureMist,
      onSurface: colors.charcoalSlate,
      outline: colors.blackShadow,
      onSurfaceVariant: colors.titaniumEcho,
    ),

    scaffoldBackgroundColor: colors.pureMist,

    cardTheme: CardThemeData(
      color: colors.white,
      // elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppTheme.defaultRadius),
      ),
    ),

    inputDecorationTheme: decorations.inputDecorationLightTheme,

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTheme.defaultRadius),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
      ),
    ),

    dividerTheme: DividerThemeData(color: colors.blackShadow, thickness: 1),
  );

  // @override
  // ThemeData get darkThemeData => ThemeData(
  //   useMaterial3: useMaterial3,
  //   brightness: Brightness.dark,
  //   fontFamily: fontFamily,

  //   colorScheme: ColorScheme(
  //     brightness: Brightness.dark,
  //     primary: colors.indigo,
  //     onPrimary: colors.midnightAbyss,
  //     secondary: colors.violet,
  //     onSecondary: colors.midnightAbyss,
  //     tertiary: colors.cyan,
  //     onTertiary: colors.midnightAbyss,
  //     error: colors.crimsonPulse,
  //     onError: colors.red,
  //     surface: colors.white50,
  //     onSurface: colors.darkGrey,
  //     outline: colors.frostedGlass,
  //   ),

  //   scaffoldBackgroundColor: colors.white50,

  //   cardTheme: CardThemeData(
  //     color: colors.carbonNight,
  //     elevation: 0,
  //     shape: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.circular(AppTheme.defaultRadius),
  //     ),
  //   ),

  //   inputDecorationTheme: decorations.inputDecorationDarkTheme,

  //   elevatedButtonTheme: ElevatedButtonThemeData(
  //     style: ElevatedButton.styleFrom(
  //       shape: RoundedRectangleBorder(
  //         borderRadius: BorderRadius.circular(AppTheme.defaultRadius),
  //       ),
  //       padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
  //     ),
  //   ),

  //   dividerTheme: DividerThemeData(color: colors.frostedGlass, thickness: 1),
  // );

  @override
  ThemeData get darkThemeData => ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    fontFamily: fontFamily,

    colorScheme: ColorScheme(
      brightness: Brightness.dark,
      primary: colors.primary, // Indigo suave
      onPrimary: colors.midnightAbyss,
      secondary: colors.secondary, // Violeta pastel
      onSecondary: colors.midnightAbyss,
      tertiary: colors.cyan,
      onTertiary: colors.midnightAbyss,
      error: colors.crimsonPulse,
      onError: colors.white,
      surface: const Color(0xFF0F172A), // Fundo azulado profundo
      onSurface: const Color(
        0xFFF1F5F9,
      ), // Branco acinzentado suave para leitura
      outline: const Color(0xFF334155), // Bordas discretas
      onSurfaceVariant: const Color(0xFF94A3B8), // Labels e hints
    ),

    scaffoldBackgroundColor: const Color(0xFF020617), // Fundo total

    cardTheme: CardThemeData(
      color: const Color(0xFF1E293B), // Card um pouco mais claro que o fundo
      elevation: 0,
      shape: RoundedRectangleBorder(
        side: const BorderSide(
          color: Color(0xFF334155),
          width: 1,
        ), // Borda fina para definição
        borderRadius: BorderRadius.circular(AppTheme.defaultRadius),
      ),
    ),

    // Customização para dar aquele ar moderno (Lara AI)
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color(0xFF0F172A),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppTheme.defaultRadius),
        borderSide: const BorderSide(color: Color(0xFF334155)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppTheme.defaultRadius),
        borderSide: const BorderSide(color: Color(0xFF334155)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppTheme.defaultRadius),
        borderSide: BorderSide(color: colors.primary, width: 2),
      ),
      hintStyle: const TextStyle(color: Color(0xFF64748B)),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: colors.primary,
        foregroundColor: const Color(0xFF0F172A),
        elevation: 0,
        // fontWeight: FontWeight.bold,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTheme.defaultRadius),
        ),
      ),
    ),

    dividerTheme: const DividerThemeData(
      color: Color(0xFF334155),
      thickness: 1,
      indent: 16,
      endIndent: 16,
    ),
  );

  @override
  AppDecorations get decorations => LaraV1Decorations(this);

  @override
  AppTextStyles get textStyles => LaraV1TextStyles();
}
