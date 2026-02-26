import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'routing/app_router_provider.dart';
import '../core/domain/configs/app_config.dart';
import '../core/application/controllers/load_app_controller.dart';
import '../core/presentation/controllers/theme_controller.dart';
import '../core/presentation/widgets/life_cycle_widget.dart';
import '../core/presentation/widgets/screen_config_widget.dart';
import '../core/presentation/widgets/theme_widget.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final routerConfig = ref.watch(appRouterProvider);
    final themeController = ref.watch(themeControllerProvider);
    final theme =
        themeController.asData?.value ??
        ref.read(themeControllerProvider.notifier).themeState;

    ref.watch(loadAppControllerProvider);

    return ThemeWidget(
      key: const ValueKey('themeWidget'),
      theme: theme.selected,
      child: LifeCycleWidget(
        child: ScreenConfigWidget(
          child: MaterialApp.router(
            restorationScopeId: AppConfig.restorationScopeId,
            title: AppConfig.appName,
            theme: theme.selected.lightThemeData,
            darkTheme: theme.selected.darkThemeData,
            themeMode: theme.mode,
            builder: FlutterSmartDialog.init(),
            routerConfig: routerConfig,
          ),
        ),
      ),
    );
  }
}
