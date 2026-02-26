import 'package:flutter/foundation.dart';

import '../../../../core/application/extensions/hardcoded_string_extension.dart';
import '../../../../core/domain/exceptions/app_exception.dart';

@immutable
final class CreateChatException extends AppException {
  CreateChatException([String? message, StackTrace? stackTrace])
    : super(
        message ?? 'Sorry, we have an internal problem, contact us.'.hardcoded,
        stackTrace: stackTrace,
      );
}
