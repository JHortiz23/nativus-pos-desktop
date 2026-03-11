import 'package:flutter/widgets.dart';
import 'package:nativus_pos_desktop/l10n/app_localizations.dart';

/// Provides the localization delegates and supported locales for the app.
abstract final class AppLocalizationsSetup {
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    AppLocalizations.delegate,
    // GlobalMaterialLocalizations.delegate,
    // GlobalWidgetsLocalizations.delegate,
    // GlobalCupertinoLocalizations.delegate,
  ];

  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es'),
  ];
}
