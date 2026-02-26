import 'package:flutter/foundation.dart';
import '../../application/extensions/hardcoded_string_extension.dart';
import 'app_exception.dart';

@immutable
final class LaraConfigException extends AppException {
  LaraConfigException([String? message, StackTrace? stackTrace])
    : super(
        message ??
            'Error trying to manipulate lara config. Assuming default parameters.'
                .hardcoded,
        stackTrace: stackTrace,
      );
}
