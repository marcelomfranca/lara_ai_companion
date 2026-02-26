import 'package:flutter/material.dart';

class EmailIcon extends StatelessWidget {
  const EmailIcon({super.key, this.size, this.color});

  final double? size;
  final Color? color;

  @override
  Widget build(BuildContext context) =>
      Icon(Icons.email_outlined, size: size, color: color);
}
