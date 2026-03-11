import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:gfyb_admin_web/application/constants/assets.dart';
import 'package:gfyb_admin_web/application/application.dart';
import 'package:gfyb_admin_web/features/activities/presentation/blocs/act_bloc/activities_bloc.dart';
import 'package:gfyb_admin_web/l10n/app_localizations.dart';
import 'package:gfyb_admin_web/application/routes/routes.dart';
import 'package:gfyb_admin_web/application/theme/theme.dart';
import 'package:gfyb_admin_web/core/navigation/active_module_cubit.dart';
import 'package:gfyb_admin_web/application/injector.dart';
import 'package:gfyb_admin_web/features/products/presentation/blocs/products_bloc.dart';
import 'package:gfyb_admin_web/features/submissions/presentation/blocs/submissions_bloc/submissions_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:gfyb_admin_web/features/auth/di/auth_providers.dart';
import 'package:gfyb_admin_web/features/auth/presentation/login/cubit/login_cubit.dart';
import 'package:gfyb_admin_web/features/auth/presentation/login/session/cubit/auth_session_cubit.dart';
import 'package:gfyb_admin_web/firebase_options.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

import 'features/user_reviews/presentation/blocs/user review bloc/user_review_bloc.dart';

Future<void> main() async {
  // Use path URL strategy for web
  setUrlStrategy(PathUrlStrategy());

  // Ensure widgets binding for async initialization
  WidgetsFlutterBinding.ensureInitialized();
  // Get environment variables

  await Assets.precacheAllSvgs();
  await dotenv.load(fileName: kReleaseMode ? ".env.prod" : ".env.dev");


  // Initialize DI
  registerAuthDependencies();
  registerAuthPresentation();
  await initInjector();
  // Configure Firebase persistence for web
  if (kIsWeb) {
    await configureFirebaseWebPersistence();
  }

  final sessionCubit = di<AuthSessionCubit>()..start();
  final router = createAppRouter(sessionCubit);

  runApp(AppRoot(sessionCubit: sessionCubit, router: router));
}

Future<void> configureFirebaseWebPersistence() async {
  await fb.FirebaseAuth.instance.setPersistence(fb.Persistence.LOCAL);
}

class AppRoot extends StatefulWidget {
  final AuthSessionCubit sessionCubit;
  final GoRouter router;

  const AppRoot({super.key, required this.sessionCubit, required this.router});

  @override
  State<AppRoot> createState() => _AppRootState();
}

class _AppRootState extends State<AppRoot> {
  final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) => MultiBlocProvider(
    providers: [
      // BlocProvider<AuthSessionCubit>.value(value: widget.sessionCubit),
      // BlocProvider(create: (_) => di<LoginCubit>()),
      // BlocProvider(create: (context) => sl<SubmissionsBloc>()),
    ],
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
      builder: (context, child) {
        return child ?? const SizedBox.shrink();
      },
    ),
  );
}
