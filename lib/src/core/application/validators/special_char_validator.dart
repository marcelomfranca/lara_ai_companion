import 'package:flutter/foundation.dart';
import '../extensions/hardcoded_string_extension.dart';
import '../../domain/exceptions/validator_exception.dart';
import '../../domain/misc/string_validator.dart';

import 'special_unicode_char_validator.dart';

class SpecialCharValidator implements StringValidator {
  @override
  bool isValid(String value) {
    final regex = RegExp(r'^(?=.*[!@#$%^&*\-_+=:;,.?/|()\]\[{}\\~<>"`]).*$');
    final regexUnicode = SpecialUnicodeCharValidator().regex;

    if (value.isNotEmpty) {
      debugPrint('REGEX: ${regexUnicode.hasMatch(value)}');
    }

    if (regex.hasMatch(value) || regexUnicode.hasMatch(value)) return true;

    throw ValidatorException(
      'Must contain at least one special character'.hardcoded,
    );
  }
}
