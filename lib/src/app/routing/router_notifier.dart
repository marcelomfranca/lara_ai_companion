import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/application/controllers/load_app_controller.dart';
import '../../features/auth/presentation/controllers/auth_controller.dart';

final class RouterNotifier extends ChangeNotifier {
  RouterNotifier(this._ref) {
    _ref.listen(loadAppControllerProvider, (_, _) => notifyListeners());
    _ref.listen(authControllerProvider, (_, _) => notifyListeners());
  }

  final Ref _ref;

  Future<String?> redirect(BuildContext context, GoRouterState state) async {
    final publicRoutes = ['/signIn', '/signUp'];
    final loadAppController = _ref.read(loadAppControllerProvider);
    final appLoaded = loadAppController.asData?.value ?? false;
    final auth = _ref.read(authControllerProvider);

    final isSplash = (state.uri.path == '/splash');

    if (isSplash && !appLoaded) {
      return null;
    }

    if (loadAppController.hasError) return '/splash'; //TODO: /error

    final user = auth.value;
    final isLoggingIn = publicRoutes.contains(state.uri.path);

    if (user == null) {
      final isPublicRoute = publicRoutes.contains(state.uri.path);

      return isPublicRoute ? null : '/signIn';
    }

    if (isLoggingIn || (state.uri.path == '/splash')) return '/dashboard';

    return null;
  }
}
