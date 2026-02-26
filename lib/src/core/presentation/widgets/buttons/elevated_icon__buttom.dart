import 'package:flutter/material.dart';

class ElevatedIconButton extends StatelessWidget {
  const ElevatedIconButton({
    super.key,
    required this.text,
    this.onTap,
    this.width,
    this.height,
    this.prefix,
    this.decoration,
  });

  final String text;
  final VoidCallback? onTap;
  final double? width;
  final double? height;
  final Widget? prefix;
  final Decoration? decoration;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 4,
      ),
      // icon: const Icon(Icons.add_comment),
      icon: prefix,
      label: Text(
        text,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
    );
  }
}
