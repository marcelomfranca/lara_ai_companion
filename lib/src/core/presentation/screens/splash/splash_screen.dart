import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../application/extensions/hardcoded_string_extension.dart';
import '../../../application/extensions/theme_build_context_extension.dart';
import '../../widgets/lara_text_logo.dart';
import '../../widgets/lara_logo.dart';
import '../../widgets/screen_config_widget.dart';
import '../../widgets/spinkit_three_bounce.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.width;

    return ScreenConfigWidget(
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Container(
              decoration: context.decorations.linearDarkGradientDecoration,
            ),
            Container(
                  width: size * 0.65,
                  height: size * 0.65,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        context.colors.etherealVoid,
                        context.colors.luminousVeil,
                      ],
                      stops: [0.0, 0.7],
                    ),
                  ),
                )
                .animate(
                  delay: 3.seconds,
                  onPlay: (controller) => controller.repeat(reverse: true),
                ) // Loop Infinito
                .scale(
                  begin: const Offset(1, 1),
                  end: const Offset(1.2, 1.2),
                  duration: 2.seconds,
                  curve: Curves.easeInOut,
                )
                .fadeIn(
                  // Simula o opacity: [0.3, 0.6, 0.3]
                  begin: 0.3,
                  duration: 2.seconds,
                  curve: Curves.easeInOut,
                ),
            Material(
              type: MaterialType.transparency,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  LaraLogo(size: size * 0.25).animate().scaleY(
                    begin: 0.0,
                    duration: 800.ms,
                    curve: Curves.easeIn,
                  ),
                  const SizedBox(height: 16),
                  LaraTextLogo(size: size * 0.10)
                      .animate(delay: 0.3.ms)
                      .fadeIn(
                        begin: 0,
                        delay: 0.3.ms,
                        duration: 1.seconds,
                        curve: Curves.easeInOut,
                      )
                      .slideY(begin: 0.5, end: 0, duration: 500.ms),
                  const SizedBox(height: 16),
                  Text(
                        'Your intelligent conversation partner'.hardcoded,
                        style: TextStyle(
                          fontSize: ((size * 0.10) / 2) - 6,
                          color: Colors.white70,
                        ),
                      )
                      .animate(delay: 0.6.ms)
                      .fadeIn(
                        begin: 0,
                        delay: 0.6.ms,
                        duration: 1.seconds,
                        curve: Curves.easeInOut,
                      )
                      .slideY(begin: 1.0, end: 0, duration: 500.ms),
                  const SizedBox(height: 16),
                  SpinKitThreeBounce(color: Colors.white38, size: size * 0.05)
                      .animate(delay: 1.seconds)
                      .fadeIn(
                        begin: 0,
                        delay: 0.7.seconds,
                        duration: 100.ms,
                        curve: Curves.easeInOut,
                      ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
