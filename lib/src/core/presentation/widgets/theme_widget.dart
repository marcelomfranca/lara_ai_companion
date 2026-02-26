import 'package:flutter/material.dart';
import '../../domain/theme/app_theme.dart';

class ThemeWidget extends InheritedWidget {
  const ThemeWidget({super.key, required this.theme, required super.child});

  final AppTheme theme;

  static ThemeWidget? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ThemeWidget>();
  }

  static ThemeWidget of(BuildContext context) {
    final ThemeWidget? result = maybeOf(context);
    assert(result != null, 'No theme found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(ThemeWidget oldWidget) => theme != oldWidget.theme;
}
