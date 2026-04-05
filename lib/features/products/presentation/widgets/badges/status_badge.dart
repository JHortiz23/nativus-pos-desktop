import 'package:flutter/material.dart';
import 'package:nativus_pos_desktop/application/theme/theme.dart';
import 'package:nativus_pos_desktop/l10n/app_localizations.dart';

class StatusBadge extends StatelessWidget {
  const StatusBadge({super.key, required this.isActive});

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    final localizations = AppLocalizations.of(context)!;
    final foreground = isActive ? colorScheme.baseGreen : colorScheme.textMuted;
    final background = isActive
        ? colorScheme.baseGreen.withValues(alpha: 0.12)
        : colorScheme.darkSurfaceAlt;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: colorScheme.softBorder),
      ),
      child: Text(
        isActive
            ? localizations.product_card_status_active
            : localizations.product_card_status_inactive,
        style: theme.textTheme.bodyLarge?.copyWith(
          color: foreground,
          fontSize: 13,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
