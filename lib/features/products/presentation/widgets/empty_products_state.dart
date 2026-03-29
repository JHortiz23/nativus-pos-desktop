import 'package:flutter/material.dart';
import 'package:nativus_pos_desktop/application/theme/theme.dart';
import 'package:nativus_pos_desktop/l10n/app_localizations.dart';

class EmptyProductsState extends StatelessWidget {
  const EmptyProductsState({super.key, required this.query});

  final String query;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    final localizations = AppLocalizations.of(context)!;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
      decoration: BoxDecoration(
        color: colorScheme.darkSurfaceAlt,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: colorScheme.softBorder),
      ),
      child: Column(
        children: [
          Icon(
            Icons.search_off_rounded,
            size: 42,
            color: colorScheme.accentPrimary,
          ),
          const SizedBox(height: 16),
          Text(
            localizations.no_products_found,
            style: theme.textTheme.headlineSmall?.copyWith(
              color: colorScheme.baseWhite,
              fontSize: 22,
              fontWeight: FontWeight.w800, 
            ),
          ),
          const SizedBox(height: 8),
          Text(
            query.isEmpty
                ? localizations.empty_products_try_other_category
                : localizations.empty_products_no_matches,
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: colorScheme.textMuted,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }
}
