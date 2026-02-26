import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lara_ai/src/features/ai/presentation/controllers/chat_list_controller.dart';
import '../../../../../core/application/extensions/hardcoded_string_extension.dart';
import '../../../../../core/application/extensions/theme_build_context_extension.dart';
import '../../../../../core/presentation/controllers/theme_controller.dart';
import '../../../../../core/presentation/screens/settings/settings_screen.dart';
import '../../../../../core/presentation/widgets/screen_config_widget.dart';
import '../../controllers/navigation_index_controller.dart';
import '../../../../auth/presentation/controllers/auth_controller.dart';
import '../../../../auth/presentation/screens/profile/profile_screen.dart';
import 'widgets/dashboard_chat_list.dart';

class DashboardScreeen extends ConsumerStatefulWidget {
  const DashboardScreeen({super.key});

  @override
  ConsumerState<DashboardScreeen> createState() => _DashboardScreeenState();
}

class _DashboardScreeenState extends ConsumerState<DashboardScreeen> {
  late final _themeController = ref.read(themeControllerProvider.notifier);
  late final _authController = ref.watch(authControllerProvider);
  late final _user = _authController.value?.name ?? '';

  void _onItemTapped(int value) =>
      ref.read(navigationIndexControllerProvider.notifier).setIndex(value);

  @override
  Widget build(BuildContext context) {
    final themeController = ref.watch(themeControllerProvider);
    final themeMode =
        themeController.asData?.value.mode ??
        ref.read(themeControllerProvider.notifier).themeState.mode;
    final isDarkMode = (themeMode == ThemeMode.dark);

    final currentIndex = ref.watch(navigationIndexControllerProvider);

    return ScreenConfigWidget(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: Scaffold(
          extendBody: true,
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF6366F1),
                    Color(0xFF7C3AED),
                    Color(0xFF9333EA),
                  ],
                ),
              ),
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Hello, $_user'.hardcoded,
                  style: context.textStyles.text18Bold.copyWith(
                    color: Colors.white,
                    overflow: TextOverflow.fade,
                  ),
                ),
                Text(
                  'Ready for a conversation?'.hardcoded,
                  style: context.textStyles.text12.copyWith(
                    color: Colors.white.withValues(alpha: 0.8),
                  ),
                ),
              ],
            ),
            actions: [
              IconButton(
                icon: Icon(
                  isDarkMode
                      ? Icons.light_mode_outlined
                      : Icons.nightlight_outlined,
                  color: Colors.white,
                  size: 16,
                ),
                onPressed: () => _themeController.toggleThemeMode(),
              ),
            ],
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          body: SafeArea(
            top: true,
            bottom: true,
            child: IndexedStack(
              index: currentIndex,
              children: const <Widget>[
                DashboardChatList(key: ValueKey('DashboardChat')),
                ProfileScreen(key: ValueKey('ProfileScreen')),
                SettingsScreen(key: ValueKey('SettingsScreen')),
              ],
            ),
          ),
          floatingActionButton: (currentIndex == 0)
              ? FloatingActionButton(
                  onPressed: () async {
                    await context.push('/chat');

                    ref.read(chatListControllerProvider.notifier).getChats();
                  },
                  backgroundColor: context.colors.primary,
                  elevation: 4,
                  child: const Icon(
                    Icons.add_comment_rounded,
                    color: Colors.white,
                  ),
                )
              : null,
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: context.colors.darkGrey,
                  width: 1.0,
                ), // Add top border
              ),
            ),
            child: BottomNavigationBar(
              useLegacyColorScheme: true,
              elevation: 0.0,
              type: BottomNavigationBarType.shifting,
              selectedItemColor: context.colors.digitalIndigo,
              unselectedItemColor: context.colors.titaniumEcho,
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.chat_bubble_outline_outlined),
                  label: 'Chats'.hardcoded,
                  // backgroundColor: context.colors.digitalIndigo,
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person_2_outlined),
                  label: 'Profile'.hardcoded,
                  // backgroundColor: context.colors.vividOrchid,
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.settings),
                  label: 'Settings'.hardcoded,
                  // backgroundColor: context.colors.violet,
                ),
              ],
              currentIndex: currentIndex,
              onTap: _onItemTapped,
            ),
          ),
        ),
      ),
    );
  }
}
