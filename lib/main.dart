import 'dart:async';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nativus_pos_desktop/application/localization/app_localizations_setup.dart';
import 'package:nativus_pos_desktop/application/injector.dart';
import 'package:nativus_pos_desktop/application/theme/theme.dart';
import 'package:nativus_pos_desktop/core/enums/sidebar_options_enum.dart';
import 'package:nativus_pos_desktop/features/auth/presentation/pages/login_page.dart';
import 'package:nativus_pos_desktop/features/app_shell/presentation/pages/app_shell_page.dart';
import 'package:nativus_pos_desktop/features/app_shell/presentation/pages/menu_placeholder_page.dart';
import 'package:nativus_pos_desktop/features/app_shell/presentation/pages/point_of_sale_page.dart';
import 'package:nativus_pos_desktop/l10n/app_localizations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load environment variables
  const appMode = String.fromEnvironment('MODE', defaultValue: 'DEV');
  final normalizedEnv = appMode.toLowerCase();
  final envFileName = normalizedEnv == 'prod' ? '.env.prod' : '.env.dev';

  await dotenv.load(fileName: envFileName);

  // Initialize DI
  await initInjector();

  final router = GoRouter(
    routes: [
      GoRoute(path: '/', builder: (context, state) => const LoginPage()),
      ShellRoute(
        builder: (context, state, child) =>
            AppShellPage(location: state.uri.toString(), child: child),
        routes: [
          GoRoute(
            path: '/app/dashboard',
            builder: (context, state) =>
                const MenuPlaceholderPage(section: MenuSection.dashboard),
          ),
          GoRoute(
            path: '/app/point-of-sale',
            builder: (context, state) => const PointOfSalePage(),
          ),
          GoRoute(
            path: '/app/table-management',
            builder: (context, state) =>
                const MenuPlaceholderPage(section: MenuSection.tableManagement),
          ),
          GoRoute(
            path: '/app/products',
            builder: (context, state) =>
                const MenuPlaceholderPage(section: MenuSection.products),
          ),
          GoRoute(
            path: '/app/reports',
            builder: (context, state) =>
                const MenuPlaceholderPage(section: MenuSection.reports),
          ),
          GoRoute(
            path: '/app/settings',
            builder: (context, state) =>
                const MenuPlaceholderPage(section: MenuSection.settings),
          ),
        ],
      ),
    ],
  );

  runApp(AppRoot(router: router));
}

class AppRoot extends StatefulWidget {
  final GoRouter router;

  const AppRoot({super.key, required this.router});

  @override
  State<AppRoot> createState() => _AppRootState();
}

class _AppRootState extends State<AppRoot> {
  final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  @override
  Widget build(BuildContext context) => MaterialApp.router(
    onGenerateTitle: (context) => AppLocalizations.of(context)!.appTitle,
    debugShowCheckedModeBanner: false,
    scaffoldMessengerKey: _scaffoldMessengerKey,
    localizationsDelegates: AppLocalizationsSetup.localizationsDelegates,
    supportedLocales: AppLocalizationsSetup.supportedLocales,
    theme: AppTheme.build(),
    routerConfig: widget.router,
    themeAnimationStyle: AnimationStyle(
      curve: Curves.easeInOut,
      duration: const Duration(milliseconds: 300),
      reverseCurve: Curves.easeInOut,
      reverseDuration: const Duration(milliseconds: 300),
    ),
  );
}
