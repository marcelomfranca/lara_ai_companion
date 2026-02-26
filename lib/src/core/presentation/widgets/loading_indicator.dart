import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({
    super.key,
    this.padding,
    this.size,
    this.strokeWidth,
  });

  final EdgeInsets? padding;
  final double? size;
  final double? strokeWidth;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: SizedBox(
        width: size ?? 32,
        height: size ?? 32,
        child: Center(
          child: CircularProgressIndicator(strokeWidth: strokeWidth ?? 3.5),
        ),
      ),
    );
  }
}
