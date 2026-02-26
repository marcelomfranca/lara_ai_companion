import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../themes/lara_v1_system_chrome_config.dart';

class SystemChromeConfigWidget extends StatefulWidget {
  const SystemChromeConfigWidget({super.key, required this.child});

  final Widget child;

  @override
  State<SystemChromeConfigWidget> createState() =>
      _SystemChromeConfigWidgetState();
}

class _SystemChromeConfigWidgetState extends State<SystemChromeConfigWidget> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Configure SO ui style
      final systemChromeConfig = LaraV1SystemChromeConfig();

      SystemChrome.setSystemUIOverlayStyle(
        systemChromeConfig.systemUiOverlayStyleDarkMode,
      );

      SystemChrome.setEnabledSystemUIMode(
        systemChromeConfig.systemUiMode,
        overlays: systemChromeConfig.systemUiOverlay,
      );
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
