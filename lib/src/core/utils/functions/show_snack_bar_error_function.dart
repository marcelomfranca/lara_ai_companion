import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import '../../application/extensions/theme_build_context_extension.dart';
import '../../domain/exceptions/app_exception.dart';
import '../../presentation/widgets/theme_widget.dart';

void showSnackBarOnError(Object error, BuildContext context) {
  SmartDialog.dismiss();

  var errorMessage = error.toString();

  if (error is AppException) errorMessage = error.message;

  showSnackBar(context, errorMessage, AnimatedSnackBarType.error);
}

void showSnackBar(
  BuildContext context,
  String text,
  AnimatedSnackBarType type,
) {
  AnimatedSnackBar(
    builder: ((context) {
      final theme = ThemeWidget.maybeOf(context)?.theme;
      final error = theme?.colors.error ?? Colors.red;
      final titaniumEcho = theme?.colors.error ?? Colors.grey;
      final white = theme?.colors.white ?? Colors.white;

      return MaterialAnimatedSnackBar(
        messageText: text,
        type: AnimatedSnackBarType.info,
        backgroundColor: error,
        foregroundColor: white,
        titleTextStyle: TextStyle(color: titaniumEcho),
      );
    }),
  ).show(context);
}
