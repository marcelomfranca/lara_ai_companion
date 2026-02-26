import 'package:flutter/material.dart';

class InkWellNoStyleButton extends StatelessWidget {
  const InkWellNoStyleButton({
    super.key,
    this.onTap,
    this.child,
    this.padding = const EdgeInsets.all(5.0),
    this.color,
  });

  final VoidCallback? onTap;
  final Widget? child;
  final EdgeInsets padding;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Material(
      clipBehavior: Clip.hardEdge,
      color: color ?? Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: InkWell(
        focusColor: Colors.transparent,
        hoverColor: Colors.transparent,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: onTap,
        child: Padding(padding: padding, child: child),
      ),
    );
  }
}
