import 'dart:async';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nativus_pos_desktop/application/application.dart';
import 'package:nativus_pos_desktop/application/injector.dart';
import 'package:nativus_pos_desktop/application/providers/app_bloc_providers.dart';
import 'package:nativus_pos_desktop/application/theme/theme.dart';
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

  final router = AppRouter.createRouter();

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
  Widget build(BuildContext context) => AppBlocProviders(
    child: MaterialApp.router(
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
    ),
  );
}
