import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/application/extensions/async_value_extension.dart';
import '../../../../../core/application/extensions/hardcoded_string_extension.dart';
import '../../../../../core/application/extensions/theme_build_context_extension.dart';
import '../../../../../core/application/validators/no_whitespace_char_validator.dart';
import '../../../../../core/application/validators/one_lowercase_letter_validator.dart';
import '../../../../../core/application/validators/one_numeric_digit_validator.dart';
import '../../../../../core/application/validators/one_uppercase_letter_validator.dart';
import '../../../../../core/application/validators/password_length_validator.dart';
import '../../../../../core/application/validators/special_char_validator.dart';
import '../../../../../core/application/validators/special_unicode_char_validator.dart';
import '../../../../../core/domain/exceptions/validator_exception.dart';
import '../../../../../core/domain/misc/lower_case_text_formatter.dart';
import '../../../../../core/domain/misc/regex_util.dart';
import '../../../../../core/domain/misc/string_validator.dart';
import '../../../../../core/presentation/widgets/buttons/ink_well_no_style_button.dart';
import '../../../../../core/presentation/widgets/buttons/primary_flat_button.dart';
import '../../../../../core/presentation/widgets/icons/email_icon.dart';
import '../../../../../core/presentation/widgets/icons/user_icon.dart';
import '../../../../../core/presentation/widgets/prefix_icon_container.dart';
import '../../../../../core/presentation/widgets/screen_config_widget.dart';
import '../../controllers/auth_controller.dart';
import 'controllers/signup_controller.dart';
import 'widgets/signup_header.dart';
import '../../widgets/form_title.dart';
import '../../widgets/password_field.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});

  @override
  ConsumerState<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  late final _controller = ref.read(signupControllerProvider.notifier);
  late final _authController = ref.read(authControllerProvider.notifier);
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  void _signUp() {
    final name = _nameController.text.trim();
    final email = _emailController.text;
    final password = _passwordController.text;

    final validated = _controller.validate(
      name: name,
      email: email,
      password: password,
      formState: _formKey.currentState,
    );

    if (validated) _authController.createAccount(name, email, password);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue<void>>(
      authControllerProvider,
      (_, state) => state.showSnackBarOnError(context),
    );

    ref.listen<AsyncValue<void>>(
      signupControllerProvider,
      (_, state) => state.showSnackBarOnError(context),
    );

    final authState = ref.watch(authControllerProvider);
    final state = ref.watch(signupControllerProvider);
    final isLoading = ((authState.isLoading || state.isLoading) == true);

    return ScreenConfigWidget(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: Scaffold(
          extendBody: true,
          extendBodyBehindAppBar: true,
          body: SafeArea(
            top: true,
            bottom: true,
            child: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      const SignUpHeader()
                          .animate(delay: 0.3.ms)
                          .fadeIn(
                            begin: 0,
                            duration: 300.ms,
                            curve: Curves.easeInOut,
                          )
                          .slideY(begin: 0.2, end: 0, duration: 600.ms),
                      const SizedBox(height: 16),
                      Form(
                            key: _formKey,
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(
                                  20,
                                  0,
                                  20,
                                  0,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    SizedBox(height: 15),
                                    FormTitle(text: 'Name'.hardcoded),
                                    TextFormField(
                                      key: const ValueKey('signup_name'),
                                      controller: _nameController,
                                      maxLength: 40,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.allow(
                                          RegexUtil.nameChars,
                                        ),
                                        FilteringTextInputFormatter.deny(
                                          SpecialUnicodeCharValidator().regex,
                                        ),
                                      ],
                                      textCapitalization:
                                          TextCapitalization.sentences,
                                      decoration: context.decorations.textField
                                          .copyWith(
                                            hintText: 'Name',
                                            prefixIcon:
                                                const PrefixIconContainer(
                                                  child: UserIcon(),
                                                ),
                                            counterText: '',
                                          ),
                                      keyboardType: TextInputType.text,
                                    ),
                                    const SizedBox(height: 5),
                                    FormTitle(text: 'Email'.hardcoded),
                                    TextFormField(
                                      key: const ValueKey('signup_email_field'),
                                      controller: _emailController,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.deny(
                                          RegExp('[ ]'),
                                        ),
                                        LowerCaseTextFormatter(),
                                      ],
                                      keyboardType: TextInputType.emailAddress,
                                      decoration: context.decorations.textField
                                          .copyWith(
                                            hintText:
                                                'you@example.com'.hardcoded,
                                            prefixIcon:
                                                const PrefixIconContainer(
                                                  child: EmailIcon(),
                                                ),
                                          ),
                                    ),
                                    const SizedBox(height: 5),
                                    Column(
                                      children: [
                                        PasswordFormField(
                                          key: const ValueKey(
                                            'signup_password_field',
                                          ),
                                          title: 'Password'.hardcoded,
                                          hintText:
                                              'Enter a password'.hardcoded,
                                          controller: _passwordController,
                                          inputFormatters: [
                                            FilteringTextInputFormatter.deny(
                                              ' ',
                                            ),
                                          ],
                                          validators: <StringValidator>[
                                            NoWhitespaceCharValidator(),
                                            OneLowercaseLetterValidator(),
                                            OneUppercaseLetterValidator(),
                                            OneNumericDigitValidator(),
                                            SpecialCharValidator(),
                                            PasswordLengthValidator(),
                                          ],
                                        ),
                                        const SizedBox(height: 15),
                                        PasswordFormField(
                                          key: const ValueKey(
                                            'signup_passwordConfirmation_field',
                                          ),
                                          hintText:
                                              'Confirm your password'.hardcoded,
                                          controller:
                                              _confirmPasswordController,
                                          confirmController:
                                              _passwordController,
                                          inputFormatters: [
                                            FilteringTextInputFormatter.deny(
                                              ' ',
                                            ),
                                          ],
                                          validator: (password, confirm) {
                                            if (password != confirm) {
                                              final message =
                                                  'Passwords did not match.'
                                                      .hardcoded;

                                              throw ValidatorException(message);
                                            }
                                          },
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 16),
                                    Builder(
                                      builder: (context) {
                                        final width = MediaQuery.of(
                                          context,
                                        ).size.width;

                                        return PrimaryFlatButton(
                                          width: width,
                                          text: 'Create Account'.hardcoded,
                                          onTap: (isLoading == true)
                                              ? null
                                              : () => _signUp(),
                                        );
                                      },
                                    ),
                                    const SizedBox(height: 16),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                        20,
                                        0,
                                        20,
                                        0,
                                      ),
                                      child: Wrap(
                                        direction: Axis.horizontal,
                                        alignment: WrapAlignment.center,
                                        crossAxisAlignment:
                                            WrapCrossAlignment.center,
                                        children: <Widget>[
                                          Text(
                                            'By signing up, you agree to our'
                                                .hardcoded,
                                            style: context.textStyles.text10w500
                                                .copyWith(
                                                  color: context
                                                      .colors
                                                      .titaniumEcho,
                                                ),
                                          ),
                                          InkWellNoStyleButton(
                                            onTap: () {},
                                            child: Text(
                                              'Terms of Service'.hardcoded,
                                              style: context
                                                  .textStyles
                                                  .text12w500
                                                  .copyWith(
                                                    color:
                                                        context.colors.primary,
                                                  ),
                                            ),
                                          ),
                                          Text(
                                            ' and '.hardcoded,
                                            style: context.textStyles.text10w500
                                                .copyWith(
                                                  color: context
                                                      .colors
                                                      .titaniumEcho,
                                                ),
                                          ),
                                          InkWellNoStyleButton(
                                            onTap: () {},
                                            child: Text(
                                              'Privacy Policy'.hardcoded,
                                              style: context
                                                  .textStyles
                                                  .text12w500
                                                  .copyWith(
                                                    color:
                                                        context.colors.primary,
                                                  ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                  ],
                                ),
                              ),
                            ),
                          )
                          .animate(delay: 0.6.ms)
                          .fadeIn(
                            begin: 0,
                            duration: 300.ms,
                            curve: Curves.easeInOut,
                          ),
                      const SizedBox(height: 16),
                      Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                'Already have an account?'.hardcoded,
                                style: context.textStyles.text12w500.copyWith(
                                  color: context.colors.titaniumEcho,
                                ),
                              ),
                              InkWellNoStyleButton(
                                onTap: () => context.go('/signIn'),
                                child: Text(
                                  'Sign in'.hardcoded,
                                  style: context.textStyles.text14w600.copyWith(
                                    color: context.colors.primary,
                                  ),
                                ),
                              ),
                            ],
                          )
                          .animate(delay: 0.9.ms)
                          .fadeIn(
                            begin: 0,
                            duration: 300.ms,
                            curve: Curves.easeInOut,
                          )
                          .slideY(begin: 0.2, end: 0, duration: 300.ms),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
