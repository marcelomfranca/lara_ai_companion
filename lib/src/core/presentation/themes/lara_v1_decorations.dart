import 'package:flutter/material.dart';
import '../../domain/theme/app_theme.dart';

final class LaraV1Decorations implements AppDecorations {
  LaraV1Decorations(this.theme);

  final AppTheme theme;

  late final defaultBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(12.0),
    borderSide: BorderSide(color: theme.colors.border, width: 1),
  );

  @override
  InputDecorationTheme get inputDecorationLightTheme => InputDecorationTheme(
    filled: true,
    fillColor: Colors.white,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppTheme.defaultRadius),
      borderSide: BorderSide(color: theme.colors.blackShadow),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppTheme.defaultRadius),
      borderSide: BorderSide(color: theme.colors.blackShadow),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppTheme.defaultRadius),
      borderSide: BorderSide(color: theme.colors.digitalIndigo, width: 2),
    ),
  );

  @override
  InputDecorationTheme get inputDecorationDarkTheme => InputDecorationTheme(
    filled: true,
    fillColor: theme.colors.blackShadow,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppTheme.defaultRadius),
      borderSide: BorderSide(color: theme.colors.frostedGlass),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppTheme.defaultRadius),
      borderSide: BorderSide(color: theme.colors.frostedGlass),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppTheme.defaultRadius),
      borderSide: BorderSide(color: theme.colors.indigo, width: 2),
    ),
  );

  @override
  InputDecoration get textField => InputDecoration(
    border: defaultBorder,
    focusedBorder: defaultBorder,
    enabledBorder: defaultBorder,
    filled: true,
    hintStyle: theme.textStyles.text16.copyWith(color: theme.colors.hintText),
    contentPadding: const EdgeInsets.only(top: 10, bottom: 10, right: 10),
    fillColor: theme.colors.white,
  );

  @override
  BoxDecoration get linearDarkGradientDecoration => BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [theme.colors.digitalIndigo, theme.colors.midnightAbyss],
    ),
  );

  @override
  BoxDecoration get primaryButtonDecoration => BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [theme.colors.digitalIndigo, theme.colors.vividOrchid],
    ),
    borderRadius: BorderRadius.circular(12),
    boxShadow: [
      BoxShadow(
        color: Colors.black45.withValues(alpha: 0.3),
        blurRadius: 12,
        offset: const Offset(0, 6),
        spreadRadius: -3,
      ),
    ],
  );

  @override
  BoxDecoration get tertiaryButtonDecoration => BoxDecoration(
    color: theme.colors.red,
    borderRadius: BorderRadius.circular(12),
    boxShadow: [
      BoxShadow(
        color: Colors.black45.withValues(alpha: 0.3),
        blurRadius: 12,
        offset: const Offset(0, 6),
        spreadRadius: -3,
      ),
    ],
  );

  @override
  BoxDecoration get secondaryTransparentButtonDecoration => BoxDecoration(
    borderRadius: BorderRadius.circular(12),
    border: Border.all(width: 1, color: theme.colors.blackShadow),
  );

  @override
  BoxDecoration get appBarGradient => const BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Color(0xFF6366F1), Color(0xFF7C3AED), Color(0xFF9333EA)],
    ),
  );
}
