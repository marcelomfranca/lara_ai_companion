import 'package:flutter/foundation.dart';
import '../../application/extensions/hardcoded_string_extension.dart';
import 'app_exception.dart';

@immutable
final class ValidatorException extends AppException {
  ValidatorException([String? message, StackTrace? stackTrace])
    : super(message ?? 'Not valided.'.hardcoded, stackTrace: stackTrace);
}
