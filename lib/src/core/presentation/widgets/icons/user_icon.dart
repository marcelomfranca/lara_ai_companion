import 'package:flutter/material.dart';

class UserIcon extends StatelessWidget {
  const UserIcon({super.key, this.size, this.color});

  final double? size;
  final Color? color;

  @override
  Widget build(BuildContext context) =>
      Icon(Icons.person_2_outlined, size: size, color: color);
}
