import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lara_ai/src/core/utils/functions/show_snack_bar_error_function.dart'
    as functions;

typedef VoidAsyncValue = AsyncValue<void>;

extension AsyncValueUI on VoidAsyncValue {
  void showSnackBarOnError(BuildContext context, {String text = ''}) =>
      whenOrNull(
        error: (error, _) => functions.showSnackBarOnError(error, context),
      );
}
