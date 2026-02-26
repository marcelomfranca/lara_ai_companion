import 'package:flutter/material.dart';

class PrefixIconContainer extends StatelessWidget {
  const PrefixIconContainer({super.key, this.width, this.height, required this.child});

  final double? width;
  final double? height;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minWidth: 50),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const SizedBox(width: 6),
          Center(child: child),
        ],
      ),
    );
  }
}
