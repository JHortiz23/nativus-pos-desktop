import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nativus_pos_desktop/application/theme/theme.dart';
import 'package:nativus_pos_desktop/l10n/app_localizations.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    final localizations = AppLocalizations.of(context)!;
    final isCompact = MediaQuery.sizeOf(context).width < 600;

    return Scaffold(
      backgroundColor: colorScheme.darkBackground,
      body: Stack(
        children: [
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(color: colorScheme.darkBackground),
            ),
          ),
          Positioned.fill(
            child: IgnorePointer(
              child: CustomPaint(
                painter: _LoginGridPainter(color: colorScheme.decorativeGrid),
              ),
            ),
          ),
          Positioned(
            top: -120,
            left: -80,
            child: _GlowOrb(color: colorScheme.accentGlow, diameter: 280),
          ),
          Positioned(
            top: 60,
            right: 120,
            child: _GlowOrb(
              color: colorScheme.accentGlow.withValues(alpha: 0.28),
              diameter: 180,
            ),
          ),
          Positioned(
            bottom: -160,
            right: -40,
            child: _GlowOrb(
              color: colorScheme.accentGlow.withValues(alpha: 0.18),
              diameter: 320,
            ),
          ),
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 560),
                  child: Column(
                    children: [
                      _BrandSection(
                        title: localizations.appTitle.toUpperCase(),
                        subtitle: localizations.loginBrandSubtitle,
                        compact: isCompact,
                      ),
                      const SizedBox(height: 36),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                          horizontal: isCompact ? 24 : 40,
                          vertical: isCompact ? 28 : 36,
                        ),
                        decoration: BoxDecoration(
                          color: colorScheme.darkSurface,
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(color: colorScheme.softBorder),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.35),
                              blurRadius: 36,
                              offset: const Offset(0, 20),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              localizations.loginTitle,
                              style: theme.textTheme.headlineMedium?.copyWith(
                                color: colorScheme.baseWhite,
                                fontSize: isCompact ? 32 : 38,
                                height: 1.05,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              localizations.loginSubtitle,
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: colorScheme.textMuted,
                                fontSize: 18,
                                height: 1.5,
                              ),
                            ),
                            const SizedBox(height: 30),
                            _LoginField(
                              label: localizations.loginUsernameLabel,
                              hintText: localizations.loginUsernameHint,
                              prefixIcon: Icons.person_outline_rounded,
                            ),
                            const SizedBox(height: 20),
                            _LoginField(
                              label: localizations.loginPasswordLabel,
                              hintText: localizations.loginPasswordHint,
                              prefixIcon: Icons.lock_outline_rounded,
                              obscureText: _obscurePassword,
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    _obscurePassword = !_obscurePassword;
                                  });
                                },
                                splashRadius: 20,
                                icon: Icon(
                                  _obscurePassword
                                      ? Icons.visibility_outlined
                                      : Icons.visibility_off_outlined,
                                ),
                                color: colorScheme.textMuted,
                              ),
                            ),
                            const SizedBox(height: 30),
                            SizedBox(
                              width: double.infinity,
                              height: 60,
                              child: FilledButton(
                                onPressed: () => context.go('/app/point-of-sale'),
                                style: FilledButton.styleFrom(
                                  backgroundColor: colorScheme.accentPrimary,
                                  foregroundColor: colorScheme.black,
                                  elevation: 0,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 24,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                  textStyle: theme.textTheme.headlineSmall
                                      ?.copyWith(
                                        color: colorScheme.black,
                                        fontSize: 17,
                                        fontWeight: FontWeight.w800,
                                      ),
                                ),
                                child: Text(localizations.loginSubmitButton),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BrandSection extends StatelessWidget {
  const _BrandSection({
    required this.title,
    required this.subtitle,
    required this.compact,
  });

  final String title;
  final String subtitle;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      children: [
        Container(
          width: compact ? 84 : 92,
          height: compact ? 84 : 92,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                colorScheme.accentPrimary,
                colorScheme.accentPrimaryDark,
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: colorScheme.accentGlow,
                blurRadius: 60,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Icon(
            Icons.eco_rounded,
            size: compact ? 40 : 44,
            color: colorScheme.darkSurface,
          ),
        ),
        const SizedBox(height: 24),
        Text(
          title,
          textAlign: TextAlign.center,
          style: theme.textTheme.headlineMedium?.copyWith(
            color: colorScheme.baseWhite,
            fontSize: compact ? 40 : 52,
            height: 1,
            fontWeight: FontWeight.w900,
            letterSpacing: -1.4,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          subtitle,
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: colorScheme.textMuted,
            fontSize: compact ? 16 : 18,
          ),
        ),
      ],
    );
  }
}

class _LoginField extends StatelessWidget {
  const _LoginField({
    required this.label,
    required this.hintText,
    required this.prefixIcon,
    this.obscureText = false,
    this.suffixIcon,
  });

  final String label;
  final String hintText;
  final IconData prefixIcon;
  final bool obscureText;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label.toUpperCase(),
          style: theme.textTheme.bodyLarge?.copyWith(
            color: colorScheme.textSoft,
            fontSize: 13,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.8,
          ),
        ),
        const SizedBox(height: 10),
        TextFormField(
          obscureText: obscureText,
          cursorColor: colorScheme.accentPrimary,
          style: theme.textTheme.bodyLarge?.copyWith(
            color: colorScheme.baseWhite,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: theme.textTheme.bodyMedium?.copyWith(
              color: colorScheme.textMuted,
              fontSize: 16,
            ),
            filled: true,
            fillColor: colorScheme.darkSurfaceAlt,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 20,
            ),
            prefixIcon: Icon(prefixIcon, color: colorScheme.textMuted),
            suffixIcon: suffixIcon,
            enabledBorder: _fieldBorder(colorScheme.softBorder),
            focusedBorder: _fieldBorder(colorScheme.accentPrimary),
            border: _fieldBorder(colorScheme.softBorder),
          ),
        ),
      ],
    );
  }

  OutlineInputBorder _fieldBorder(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: color),
    );
  }
}

class _GlowOrb extends StatelessWidget {
  const _GlowOrb({required this.color, required this.diameter});

  final Color color;
  final double diameter;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Container(
        width: diameter,
        height: diameter,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: color,
              blurRadius: diameter / 1.8,
              spreadRadius: diameter / 7,
            ),
          ],
        ),
      ),
    );
  }
}

class _LoginGridPainter extends CustomPainter {
  const _LoginGridPainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    const step = 48.0;
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1;

    for (double x = 0; x <= size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }

    for (double y = 0; y <= size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant _LoginGridPainter oldDelegate) {
    return oldDelegate.color != color;
  }
}
