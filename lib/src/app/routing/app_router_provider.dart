import 'package:go_router/go_router.dart';
import 'router_notifier.dart';
import '../../core/application/extensions/hardcoded_string_extension.dart';
import '../../core/application/observers/go_router_observer.dart';
import '../../core/core_app.dart';
import '../../core/domain/exceptions/app_exception.dart';
import '../../core/domain/misc/module.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_router_provider.g.dart';

@Riverpod(keepAlive: true)
GoRouter appRouter(Ref ref) {
  final refreshListenable = RouterNotifier(ref);
  final modules = CoreApp.modules;

  if (modules.isEmpty) throw AppException('No module registered.'.hardcoded);

  final routes = <RouteBase>[];

  for (Module module in modules) {
    routes.addAll(module.routes);
  }

  final goRouterConfig = GoRouter(
    refreshListenable: refreshListenable,
    restorationScopeId: CoreApp.routerRestorationScopeId,
    navigatorKey: CoreApp.navigatorKey,
    initialLocation: CoreApp.initialLocation,
    observers: [GoRouterObserver()],
    redirect: refreshListenable.redirect,
    routes: routes,
  );

  return goRouterConfig;
}
