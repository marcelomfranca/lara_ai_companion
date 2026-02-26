import 'package:flutter/material.dart';
import '../../../application/extensions/theme_build_context_extension.dart';
import 'base_flat_button.dart';

class PrimaryFlatButton extends StatelessWidget {
  const PrimaryFlatButton({
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
    return BaseFlatButton(
      width: width,
      height: height,
      child: Container(
        decoration: decoration ?? context.decorations.primaryButtonDecoration,
        child: TextButton(
          style: TextButton.styleFrom(
            backgroundColor: Colors.transparent,
            foregroundColor: context.colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onPressed: () {
            FocusManager.instance.primaryFocus?.unfocus();

            if (onTap != null) onTap?.call();
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              if (prefix != null) ...[prefix!],
              Text(
                text,
                maxLines: 1,
                style: context.textStyles.text16w500.copyWith(
                  color: context.colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
