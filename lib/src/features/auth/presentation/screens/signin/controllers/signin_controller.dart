import '../../../../../../core/application/extensions/hardcoded_string_extension.dart';
import '../../../../../../core/application/validators/email_validator.dart';
import '../../../../../../core/domain/exceptions/app_exception.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'signin_controller.g.dart';

@riverpod
class SigninController extends _$SigninController {
  @override
  FutureOr<void> build() {}

  bool validate({required String email, required String password}) {
    state = const AsyncValue.data(null);

    final emailErrorMessage = emailValidator(email);
    final passwordErrorMessage = passwordValidator(password);

    if (emailErrorMessage.isNotEmpty) {
      state = AsyncValue.error(
        AppException(emailErrorMessage),
        StackTrace.current,
      );
    }

    if (passwordErrorMessage.isNotEmpty) {
      state = AsyncValue.error(
        AppException(passwordErrorMessage),
        StackTrace.current,
      );
    }

    final validated =
        (emailErrorMessage.isEmpty) && (passwordErrorMessage.isEmpty);

    return validated;
  }

  String emailValidator(String email) {
    if (email.isEmpty) return 'Please enter email address.'.hardcoded;

    return EmailValidator().isValid(email) ?? '';
  }

  String passwordValidator(String password) {
    if (password.isEmpty) return 'Please enter your password.'.hardcoded;

    return '';
  }
}
