import 'package:flutter/material.dart';
import '../../../../../../core/application/extensions/theme_build_context_extension.dart';

class StatsWidget extends StatelessWidget {
  const StatsWidget({
    super.key,
    required this.title,
    this.subTitle,
    this.statsColor,
  });

  final String title;
  final String? subTitle;
  final Color? statsColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          title,
          style: context.textStyles.text24w700.copyWith(
            color: statsColor ?? context.colors.digitalIndigo,
          ),
        ),
        if ((subTitle != null)) ...[
          Text(
            subTitle!,
            style: context.textStyles.text13w500.copyWith(
              color: context.colors.titaniumEcho,
            ),
          ),
        ],
      ],
    );
  }
}
