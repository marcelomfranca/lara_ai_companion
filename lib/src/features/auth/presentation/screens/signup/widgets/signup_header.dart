import 'package:flutter/material.dart';
import '../../../../../../core/application/extensions/hardcoded_string_extension.dart';
import '../../../../../../core/application/extensions/theme_build_context_extension.dart';
import '../../../../../../core/presentation/widgets/lara_logo.dart';

class SignUpHeader extends StatelessWidget {
  const SignUpHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.width;

    return Column(
      children: <Widget>[
        LaraLogo(size: size * 0.20),
        const SizedBox(height: 16),
        Text('Join to LARA'.hardcoded, style: context.textStyles.text24w700),
        Text(
          'Create your account to get started'.hardcoded,
          style: context.textStyles.text14w500.copyWith(
            color: context.colors.titaniumEcho,
          ),
        ),
      ],
    );
  }
}
