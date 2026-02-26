import 'package:flutter/material.dart';
import '../../../application/extensions/theme_build_context_extension.dart';
import '../icons/lock_icon.dart';

class LockIconButton extends StatelessWidget {
  const LockIconButton({super.key, this.onTap, this.size, this.color});

  final VoidCallback? onTap;
  final double? size;
  final Color? color;

  @override
  Widget build(BuildContext context) => IconButton(
    onPressed: onTap,
    icon: LockIcon(size: size, color: color ?? context.colors.titaniumEcho),
  );
}
