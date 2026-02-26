import 'package:flutter/material.dart';
import '../../domain/theme/app_theme.dart';
import '../../presentation/widgets/theme_widget.dart';

extension ThemeBuildContextExtension on BuildContext {
  AppTheme get selectedTheme => ThemeWidget.of(this).theme;
  AppColors get colors => selectedTheme.colors;
  AppTextStyles get textStyles => selectedTheme.textStyles;
  AppDecorations get decorations => selectedTheme.decorations;
}
