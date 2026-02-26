import '../../domain/exceptions/validator_exception.dart';
import '../../domain/misc/string_validator.dart';

final class OneLowercaseLetterValidator implements StringValidator {
  @override
  bool isValid(String value) {
    final regex = RegExp(r'^(?=.*[a-z]).*$');

    if (regex.hasMatch(value)) return true;

    throw ValidatorException('Must contain at least one lower case letter');
  }
}
