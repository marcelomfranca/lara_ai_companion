import 'package:flutter/material.dart';

class BaseFlatButton extends StatelessWidget {
  const BaseFlatButton({
    super.key,
    this.width,
    this.height,
    required this.child,
  });

  final double? width;
  final double? height;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: width, height: height ?? 48, child: child);
  }
}
