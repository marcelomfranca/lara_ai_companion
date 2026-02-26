import '../extensions/hardcoded_string_extension.dart';
import '../../domain/exceptions/validator_exception.dart';
import '../../domain/misc/string_validator.dart';

final class OneNumericDigitValidator implements StringValidator {
  @override
  bool isValid(String value) {
    final regex = RegExp(r'^(?=.*[0-9]).*$');

    if (regex.hasMatch(value)) return true;

    throw ValidatorException('Must contain at least one number'.hardcoded);
  }
}
