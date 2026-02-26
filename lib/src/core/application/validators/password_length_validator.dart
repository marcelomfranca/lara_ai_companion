import '../../domain/exceptions/validator_exception.dart';
import '../../domain/misc/string_validator.dart';
import '../extensions/hardcoded_string_extension.dart';

final class PasswordLengthValidator implements StringValidator {
  @override
  bool isValid(String value) {
    final regex = RegExp(r'^.{10,}$');

    if (regex.hasMatch(value)) return true;

    throw ValidatorException('Must be greater than 10 characters'.hardcoded);
  }
}
