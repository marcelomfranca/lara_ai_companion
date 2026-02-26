import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../application/extensions/theme_build_context_extension.dart';

class ScreenConfigWidget extends StatelessWidget {
  const ScreenConfigWidget({super.key, required this.child, this.darkMode});

  final Widget child;
  final bool? darkMode;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = darkMode ?? false;
    final setSystemUIOverlayStyle = (isDarkMode)
        ? context.selectedTheme.systemChromeConfig.systemUiOverlayStyleDarkMode
        : context
              .selectedTheme
              .systemChromeConfig
              .systemUiOverlayStyleLightMode;

    WidgetsFlutterBinding.ensureInitialized().addPostFrameCallback((_) {
      SystemChrome.setSystemUIOverlayStyle(setSystemUIOverlayStyle);
    });

    return MediaQuery(
      data: MediaQuery.of(
        context,
      ).copyWith(textScaler: const TextScaler.linear(1.0), highContrast: false),
      child: child,
    );
  }
}
