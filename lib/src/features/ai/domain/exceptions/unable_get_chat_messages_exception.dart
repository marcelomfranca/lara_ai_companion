import 'package:flutter/foundation.dart';

import '../../../../core/application/extensions/hardcoded_string_extension.dart';
import '../../../../core/domain/exceptions/app_exception.dart';

@immutable
final class UnableGetChatMessagesException extends AppException {
  UnableGetChatMessagesException([String? message, StackTrace? stackTrace])
    : super(
        message ??
            'Sorry, unable to get chat messages, you can continue.'.hardcoded,
        stackTrace: stackTrace,
      );
}
