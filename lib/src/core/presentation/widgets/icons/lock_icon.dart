import 'package:flutter/material.dart';

class LockIcon extends StatelessWidget {
  const LockIcon({super.key, this.size, this.color});

  final double? size;
  final Color? color;

  @override
  Widget build(BuildContext context) =>
      Icon(Icons.lock_outlined, size: size, color: color);
}
