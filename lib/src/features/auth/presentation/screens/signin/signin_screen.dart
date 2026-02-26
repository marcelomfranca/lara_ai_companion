import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/application/extensions/async_value_extension.dart';
import '../../../../../core/application/extensions/hardcoded_string_extension.dart';
import '../../../../../core/application/extensions/theme_build_context_extension.dart';
import '../../../../../core/domain/misc/lower_case_text_formatter.dart';
import '../../../../../core/presentation/widgets/buttons/ink_well_no_style_button.dart';
import '../../../../../core/presentation/widgets/buttons/primary_flat_button.dart';
import '../../../../../core/presentation/widgets/icons/email_icon.dart';
import '../../../../../core/presentation/widgets/prefix_icon_container.dart';
import '../../controllers/auth_controller.dart';
import '../../../domain/enums/signin_providers_enum.dart';
import 'controllers/signin_controller.dart';
import 'widgets/signin_header.dart';
import '../../../../../core/presentation/widgets/screen_config_widget.dart';
import '../../widgets/form_title.dart';
import '../../widgets/google_flat_button.dart';
import '../../widgets/password_field.dart';

class SignInScreen extends ConsumerStatefulWidget {
  const SignInScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignInScreenState();
}

class _SignInScreenState extends ConsumerState<SignInScreen> {
  late final _controller = ref.read(signinControllerProvider.notifier);
  late final _authController = ref.read(authControllerProvider.notifier);
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _signIn({SigninProvidersEnum provider = SigninProvidersEnum.email}) {
    switch (provider) {
      case SigninProvidersEnum.email:
        final email = _emailController.text.trim();
        final password = _passwordController.text.trim();

        final validated = _controller.validate(
          email: email,
          password: password,
        );

        if (validated) {
          _authController.signInWithEmail(email: email, password: password);
        }
        break;
      case SigninProvidersEnum.google:
        _authController.signInWithGoogle();
        break;
    }
  }

  @override
  void dispose() {
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
      signinControllerProvider,
      (_, state) => state.showSnackBarOnError(context),
    );

    final authState = ref.watch(authControllerProvider);
    final state = ref.watch(signinControllerProvider);
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
                      const SignInnHeader()
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
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    SizedBox(height: 15),
                                    FormTitle(text: 'Email'.hardcoded),
                                    TextFormField(
                                      key: const ValueKey('signin_email_field'),
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
                                    PasswordFormField(
                                      key: const ValueKey(
                                        'signin_password_field',
                                      ),
                                      title: 'Password'.hardcoded,
                                      hintText: '••••••••'.hardcoded,
                                      controller: _passwordController,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.deny(' '),
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
                                          text: 'Sign In'.hardcoded,
                                          onTap: (isLoading == true)
                                              ? null
                                              : () => _signIn(),
                                        );
                                      },
                                    ),
                                    const SizedBox(height: 16),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.max,
                                      children: <Widget>[
                                        Expanded(child: Divider()),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                            10,
                                            0,
                                            10,
                                            0,
                                          ),
                                          child: Text(
                                            'or'.hardcoded,
                                            style: context.textStyles.text12w500
                                                .copyWith(
                                                  color: context
                                                      .colors
                                                      .titaniumEcho,
                                                ),
                                          ),
                                        ),
                                        Expanded(child: Divider()),
                                      ],
                                    ),
                                    const SizedBox(height: 16),
                                    Builder(
                                      builder: (context) {
                                        final width = MediaQuery.of(
                                          context,
                                        ).size.width;

                                        return GoogleFlatButton(
                                          width: width,
                                          onTap: (isLoading == true)
                                              ? null
                                              : () => _signIn(
                                                  provider: SigninProvidersEnum
                                                      .google,
                                                ),
                                        );
                                      },
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
                                'Don\'t have an account?'.hardcoded,
                                style: context.textStyles.text12w500.copyWith(
                                  color: context.colors.titaniumEcho,
                                ),
                              ),
                              InkWellNoStyleButton(
                                onTap: () => context.go('/signUp'),
                                child: Text(
                                  'Sign up'.hardcoded,
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
