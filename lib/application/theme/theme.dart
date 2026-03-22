import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

extension AppColorScheme on ColorScheme {
  Color get hint => const Color(0xFF777777);
  Color get requiredRed => const Color(0xFFC52B2B);
  Color get primaryColor => const Color(0xFF3B3767);
  Color get baseGreen => const Color(0xFF65C466);
  Color get baseOrange => const Color(0xFFF0A45F);
  Color get baseWhite => const Color(0xFFFFFFFF);
  Color get redOrange => const Color(0xFFFF4d4d);
  Color get baseGray => const Color(0xFFF3F3F3);
  Color get lightGray => const Color(0xFFF9F9F9);
  Color get white => const Color(0xFFFFFFFF);
  Color get black => const Color(0xFF000000);
  Color get darkGray => const Color(0xFF555555);
  Color get gray93 => const Color(0xFFEEEEEE);
  Color get transparent => const Color(0x00000000);
  Color get luxuryWhite => const Color(0xFFFAFAFA);
  Color get lightGreen => const Color(0xFF90EE90);
  Color get darkBackground => const Color(0xFF090D14);
  Color get darkSurface => const Color(0xFF101722);
  Color get darkSurfaceAlt => const Color(0xFF171E2A);
  Color get softBorder => const Color(0xFF283042);
  Color get decorativeGrid => const Color(0x142C3445);
  Color get accentGlow => const Color(0x59FFB11A);
  Color get accentPrimary => const Color(0xFFFFB11A);
  Color get accentPrimaryDark => const Color(0xFFF28C18);
  Color get textMuted => const Color(0xFF7E8AA8);
  Color get textSoft => const Color(0xFFA8B6D7);
}

class AppTheme {
  static const Color primaryColor = Color(0xFF3B3767);
  static const Color hint = Color(0xFF777777);
  static const Color requiredRed = Color(0xFFC52B2B);
  static const Color baseGreen = Color(0xFF65C466);
  static const Color baseOrange = Color(0xFFF0A45F);
  static const Color baseWhite = Color(0xFFFFFFFF);
  static const Color redOrange = Color(0xFFFF4d4d);
  static const Color baseGray = Color(0xFFF3F3F3);
  static const Color lightGray = Color(0xFFF9F9F9);
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color darkGray = Color(0xFF555555);
  static const Color gray93 = Color(0xFFEEEEEE);
  static const Color transparent = Color(0x00000000);
  static const Color luxuryWhite = Color(0xFFFAFAFA);
  static const Color lightGreen = Color(0xFF90EE90);
  static const Color darkBackground = Color(0xFF090D14);
  static const Color darkSurface = Color(0xFF101722);
  static const Color darkSurfaceAlt = Color(0xFF171E2A);
  static const Color softBorder = Color(0xFF283042);
  static const Color decorativeGrid = Color(0x142C3445);
  static const Color accentGlow = Color(0x59FFB11A);
  static const Color accentPrimary = Color(0xFFFFB11A);
  static const Color accentPrimaryDark = Color(0xFFF28C18);
  static const Color textMuted = Color(0xFF7E8AA8);
  static const Color textSoft = Color(0xFFA8B6D7);
  static TextTheme get textTheme => TextTheme(
        headlineSmall: GoogleFonts.raleway(
          fontSize: 20,
          height: 28 / 20,
          fontWeight: FontWeight.w600,
          color: primaryColor,
        ),
        headlineMedium: GoogleFonts.raleway(
          fontSize: 24,
          height: 28 / 24,
          fontWeight: FontWeight.w600,
          color: primaryColor,
        ),
        bodyMedium: GoogleFonts.firaSans(
          fontSize: 14,
          height: 20 / 14,
          fontWeight: FontWeight.w400,
          color: primaryColor,
        ),
        bodyLarge: GoogleFonts.firaSans(
          fontSize: 14,
          height: 20 / 14,
          fontWeight: FontWeight.w500,
          color: primaryColor,
        ),
        labelSmall: GoogleFonts.firaSans(
          fontSize: 10,
          height: 14 / 10,
          fontWeight: FontWeight.w400,
          color: primaryColor,
        ),
        labelLarge: GoogleFonts.firaSans(
          fontSize: 14,
          height: 20 / 14,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
      );

  static ThemeData build() {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: primaryColor,
      primary: primaryColor,
      error: redOrange,
      onError: redOrange,
      errorContainer: redOrange,
      onErrorContainer: redOrange
    );
    return ThemeData(
      colorScheme: colorScheme,
      primaryColor: primaryColor,
      textTheme: textTheme,
      inputDecorationTheme: InputDecorationTheme(
        contentPadding:
            const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        hintStyle: textTheme.bodyMedium!.copyWith(color: colorScheme.hint),
        fillColor: Colors.white,
        filled: true,
        hoverColor: Colors.transparent,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: colorScheme.primary),
        ),
      ),
    );
  }
}

class AppText {
  static TextStyle get body1 => AppTheme.textTheme.bodyLarge!;
  static TextStyle get body2 => AppTheme.textTheme.bodyMedium!;
  static TextStyle get button => AppTheme.textTheme.labelLarge!;
}
