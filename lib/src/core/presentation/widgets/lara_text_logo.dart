import 'package:flutter/material.dart';
import '../../application/extensions/hardcoded_string_extension.dart';
import '../../application/extensions/theme_build_context_extension.dart';

class LaraTextLogo extends StatelessWidget {
  const LaraTextLogo({super.key, this.size = 36});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          'LARA'.hardcoded,
          style: TextStyle(
            fontSize: size,
            fontWeight: FontWeight.bold,
            color: context.colors.white,
          ),
        ),
        Text(
          'AI Companion'.hardcoded,
          style: TextStyle(
            fontSize: size / 2,
            color: context.colors.white.withValues(alpha: 0.9),
          ),
        ),
      ],
    );
  }
}
