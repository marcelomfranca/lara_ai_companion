import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/application/extensions/hardcoded_string_extension.dart';
import '../../../../core/application/extensions/theme_build_context_extension.dart';
import '../../../../core/presentation/widgets/buttons/base_flat_button.dart';

class GoogleFlatButton extends StatelessWidget {
  const GoogleFlatButton({
    super.key,
    this.text,
    this.onTap,
    this.width,
    this.height,
  });

  final String? text;
  final VoidCallback? onTap;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return BaseFlatButton(
      width: width,
      height: height,
      child: Container(
        decoration: context.decorations.secondaryTransparentButtonDecoration,
        child: TextButton(
          style: TextButton.styleFrom(
            backgroundColor: context.colors.white,
            foregroundColor: context.colors.electricCyan,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onPressed: onTap,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SvgPicture.asset('assets/icons/google.svg', height: 16),
              const SizedBox(width: 16),
              Text(
                text ?? 'Continue with Google'.hardcoded,
                maxLines: 1,
                style: context.textStyles.text16w500.copyWith(
                  color: context.colors.titaniumEcho,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
