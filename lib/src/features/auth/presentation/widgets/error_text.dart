import 'package:flutter/material.dart';
import '../../../../core/application/extensions/theme_build_context_extension.dart';

class ErrorText extends StatelessWidget {
  const ErrorText({
    super.key,
    this.text = '',
    this.padding = const EdgeInsets.fromLTRB(0, 5, 15, 0),
  });

  final String text;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: text.isNotEmpty,
      child: Padding(
        padding: padding,
        child: Text(
          text,
          style: context.textStyles.text12.copyWith(
            color: context.colors.error,
          ),
        ),
      ),
    );
  }
}
