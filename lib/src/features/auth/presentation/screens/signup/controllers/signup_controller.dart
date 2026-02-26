import 'package:flutter/widgets.dart';
import '../../../../../../core/application/extensions/hardcoded_string_extension.dart';
import '../../../../../../core/application/validators/email_validator.dart';
import '../../../../../../core/domain/exceptions/app_exception.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'signup_controller.g.dart';

@riverpod
class SignupController extends _$SignupController {
  @override
  FutureOr<void> build() {}

  bool validate({
    required String name,
    required String email,
    required String password,
    FormState? formState,
  }) {
    state = const AsyncValue.data(null);

    final validator = _validator(
      name: name,
      email: email,
      password: password,
      formState: formState,
    );

    if (validator.isNotEmpty) {
      for (var error in validator) {
        state = AsyncValue.error(AppException(error), StackTrace.current);
      }
    }

    return validator.isEmpty;
  }

  List<String> _validator({
    required String name,
    required String email,
    required String password,
    FormState? formState,
  }) {
    final validator = <String>[];

    if (name.isEmpty) {
      validator.add('Enter name.'.hardcoded);
    }

    if (email.isEmpty) {
      validator.add('Please enter email address.'.hardcoded);
    } else {
      final validatedEmail = EmailValidator().isValid(email);

      if (validatedEmail != null) {
        validator.add('Please enter valid email address.'.hardcoded);
      }
    }

    if ((formState != null) && formState.validate() == false) {
      validator.add('Password is invalid.'.hardcoded);
    }

    return validator;
  }
}
