import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nativus_pos_desktop/application/localization/app_localizations_setup.dart';
import 'package:nativus_pos_desktop/application/injector.dart';
import 'package:nativus_pos_desktop/application/theme/theme.dart';
import 'package:nativus_pos_desktop/l10n/app_localizations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize DI
  await initInjector();

  // TODO: Configure router with actual routes
  final router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) =>
            const Scaffold(body: Center(child: Text('Nativus POS'))),
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
  // Widget build(BuildContext context) => MultiBlocProvider(
  //   providers: [
  //     // BlocProvider<AuthSessionCubit>.value(value: widget.sessionCubit),
  //     // BlocProvider(create: (_) => di<LoginCubit>()),
  //     // BlocProvider(create: (context) => sl<SubmissionsBloc>()),
  //   ],
  //   child: MaterialApp.router(
  //     onGenerateTitle: (context) => AppLocalizations.of(context)!.appTitle,
  //     debugShowCheckedModeBanner: false,
  //     scaffoldMessengerKey: _scaffoldMessengerKey,
  //     localizationsDelegates: AppLocalizationsSetup.localizationsDelegates,
  //     supportedLocales: AppLocalizationsSetup.supportedLocales,
  //     theme: AppTheme.build(),
  //     routerConfig: widget.router,
  //     themeAnimationStyle: AnimationStyle(
  //       curve: Curves.easeInOut,
  //       duration: const Duration(milliseconds: 300),
  //       reverseCurve: Curves.easeInOut,
  //       reverseDuration: const Duration(milliseconds: 300),
  //     ),
  //     builder: (context, child) {
  //       return child ?? const SizedBox.shrink();
  //     },
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
