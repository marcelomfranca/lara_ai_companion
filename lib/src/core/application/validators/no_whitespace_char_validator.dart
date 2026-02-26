import '../extensions/hardcoded_string_extension.dart';
import '../../domain/exceptions/validator_exception.dart';
import '../../domain/misc/string_validator.dart';

final class NoWhitespaceCharValidator implements StringValidator {
  @override
  bool isValid(String value) {
    final regex = RegExp(r'^\S*$');

    if (regex.hasMatch(value)) return true;

    throw ValidatorException('Password cannot contain whitespace'.hardcoded);
  }
}
