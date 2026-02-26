import 'package:flutter/material.dart';

class LockOpenIcon extends StatelessWidget {
  const LockOpenIcon({super.key, this.size, this.color});

  final double? size;
  final Color? color;

  @override
  Widget build(BuildContext context) =>
      Icon(Icons.lock_open_outlined, size: size, color: color);
}
