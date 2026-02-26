import 'package:email_validator/email_validator.dart' as email_validator;
import '../extensions/hardcoded_string_extension.dart';
import '../../domain/misc/string_validator.dart';

class EmailValidator implements StringValidator {
  @override
  String? isValid(String value) {
    if (email_validator.EmailValidator.validate(value)) return null;

    return 'Must contain a valid email.'.hardcoded;
  }
}
