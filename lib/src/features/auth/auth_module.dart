import 'package:go_router/go_router.dart';
import '../../core/domain/misc/module.dart';
import 'presentation/screens/signin/signin_screen.dart';
import 'presentation/screens/profile/profile_screen.dart';
import 'presentation/screens/signup/signup_screen.dart';

final class AuthModule implements Module {
  @override
  String get name => 'Auth';

  @override
  List<GoRoute> get routes => [
    GoRoute(
      name: 'signIn',
      path: '/signIn',
      builder: (context, state) => const SignInScreen(),
    ),

    GoRoute(
      name: 'signUp',
      path: '/signUp',
      builder: (context, state) => const SignUpScreen(),
    ),

    GoRoute(
      name: 'profile',
      path: '/profile',
      builder: (context, state) => const ProfileScreen(),
    ),
  ];

  @override
  List<Map<String, dynamic>> get sqlScript => [];
}
