import 'package:flutter/foundation.dart';
import '../extensions/hardcoded_string_extension.dart';
import '../../domain/exceptions/validator_exception.dart';
import '../../domain/misc/string_validator.dart';

final class SpecialUnicodeCharValidator implements StringValidator {
  final unicodeList =
      '\u2022\u221a\u03c0\u00f7\u00d7\u00a7\u00a7\u2202\u00a3\u00a2\u20ac\u00a5\u00b0\u00a9\u00ae\u2122\u2713\u2206\u0027';
  late final regex = RegExp('[${RegExp.escape(unicodeList)}]\uFE0F?');

  @override
  bool isValid(String value) {
    if (value.isNotEmpty) {
      debugPrint('REGEX: ${regex.hasMatch(value)}');
    }

    if (regex.hasMatch(value)) return true;

    throw ValidatorException(
      'Must contain at least one special character'.hardcoded,
    );
  }
}
