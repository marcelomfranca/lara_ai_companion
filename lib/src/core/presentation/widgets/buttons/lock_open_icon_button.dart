import 'package:flutter/material.dart';
import '../icons/lock_open_icon.dart';

class LockOpenIconButton extends StatelessWidget {
  const LockOpenIconButton({super.key, this.onTap, this.size, this.color});

  final VoidCallback? onTap;
  final double? size;
  final Color? color;

  @override
  Widget build(BuildContext context) => IconButton(
    onPressed: onTap,
    icon: LockOpenIcon(size: size, color: color),
  );
}
