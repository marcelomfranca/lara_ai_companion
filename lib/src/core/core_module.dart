import 'package:go_router/go_router.dart';
import 'domain/misc/module.dart';
import 'presentation/screens/about/about_screen.dart';
import 'presentation/screens/splash/splash_screen.dart';

final class CoreModule implements Module {
  @override
  String get name => 'Core';

  @override
  List<GoRoute> get routes => [
    GoRoute(
      name: 'splash',
      path: '/splash',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      name: 'about',
      path: '/about',
      builder: (context, state) => const AboutScreen(),
    ),
  ];

  @override
  List<Map<String, dynamic>> get sqlScript => [];
}
