import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../../../core/application/extensions/hardcoded_string_extension.dart';
import '../../../../../../core/application/extensions/theme_build_context_extension.dart';

class EmptyStateWidget extends StatelessWidget {
  final VoidCallback onActionPressed;

  const EmptyStateWidget({super.key, required this.onActionPressed});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: onActionPressed,
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.blue.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.forum_outlined,
                  size: 64,
                  color: Colors.blueAccent,
                ),
              ).animate().slideY(begin: 0.5, end: 0, duration: 500.ms),
            ),
            const SizedBox(height: 32),
            Text(
                  'Your journey begins here'.hardcoded,
                  style: context.textStyles.text16Bold,
                  textAlign: TextAlign.center,
                )
                .animate(delay: 0.3.ms)
                .fadeIn(
                  begin: 0,
                  delay: 0.3.ms,
                  duration: 1.seconds,
                  curve: Curves.easeInOut,
                )
                .slideY(begin: 0.5, end: 0, duration: 500.ms),
            const SizedBox(height: 12),
            Text(
                  'Lara AI is ready to chat. How about we start your first chat?'
                      .hardcoded,
                  style: context.textStyles.text14w500.copyWith(
                    color: context.colors.titaniumEcho,
                  ),
                  textAlign: TextAlign.center,
                )
                .animate(delay: 0.6.ms)
                .fadeIn(
                  begin: 0,
                  delay: 0.6.ms,
                  duration: 1.seconds,
                  curve: Curves.easeInOut,
                )
                .slideY(begin: 1.0, end: 0, duration: 500.ms),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
