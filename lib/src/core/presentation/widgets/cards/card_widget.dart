import 'package:flutter/material.dart';
import '../../../application/extensions/theme_build_context_extension.dart';

class CardWidget extends StatelessWidget {
  const CardWidget({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Expanded(
          child: Card(
            // padding: const EdgeInsets.all(20),
            // decoration: BoxDecoration(
            //   color: Colors.white,
            //   borderRadius: BorderRadius.circular(16.0),
            //   border: Border.all(color: context.colors.blackShadow, width: 1),
            //   boxShadow: [
            //     BoxShadow(
            //       color: context.colors.blackShadow,
            //       blurRadius: 16,
            //       offset: const Offset(0, 8),
            //     ),
            //   ],
            // ),
            child: Padding(padding: const EdgeInsets.all(20.0), child: child),
          ),
        ),
      ],
    );
  }
}
