import 'package:flutter/material.dart';
import 'package:nativus_pos_desktop/application/theme/theme.dart';
import 'package:nativus_pos_desktop/features/navigation/presentation/models/menu_section.dart';
import 'package:nativus_pos_desktop/l10n/app_localizations.dart';

class MenuPlaceholderPage extends StatelessWidget {
  const MenuPlaceholderPage({
    super.key,
    required this.section,
  });

  final MenuSection section;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    final localizations = AppLocalizations.of(context)!;

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.darkSurface,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: colorScheme.softBorder),
      ),
      padding: const EdgeInsets.all(28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            localizations.exampleEyebrow,
            style: theme.textTheme.bodyLarge?.copyWith(
              color: colorScheme.accentPrimary,
              fontSize: 13,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.8,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            _title(localizations),
            style: theme.textTheme.headlineMedium?.copyWith(
              color: colorScheme.baseWhite,
              fontSize: 34,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            localizations.modulePlaceholderDescription,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: colorScheme.textMuted,
              fontSize: 16,
              height: 1.6,
            ),
          ),
          const SizedBox(height: 28),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: colorScheme.darkSurfaceAlt,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: colorScheme.softBorder),
              ),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      _icon(),
                      size: 52,
                      color: colorScheme.accentPrimary,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      _title(localizations),
                      style: theme.textTheme.headlineSmall?.copyWith(
                        color: colorScheme.baseWhite,
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      localizations.modulePlaceholderCardText,
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: colorScheme.textMuted,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _title(AppLocalizations localizations) {
    switch (section) {
      case MenuSection.dashboard:
        return localizations.sidebarDashboard;
      case MenuSection.pointOfSale:
        return localizations.sidebarPointOfSale;
      case MenuSection.tableManagement:
        return localizations.sidebarTableManagement;
      case MenuSection.products:
        return localizations.sidebarProducts;
      case MenuSection.reports:
        return localizations.sidebarReports;
      case MenuSection.settings:
        return localizations.sidebarSettings;
    }
  }

  IconData _icon() {
    switch (section) {
      case MenuSection.dashboard:
        return Icons.home_outlined;
      case MenuSection.pointOfSale:
        return Icons.attach_money_rounded;
      case MenuSection.tableManagement:
        return Icons.table_restaurant_outlined;
      case MenuSection.products:
        return Icons.inventory_2_outlined;
      case MenuSection.reports:
        return Icons.bar_chart_rounded;
      case MenuSection.settings:
        return Icons.settings_outlined;
    }
  }
}
