import 'package:flutter/material.dart';
import 'package:nativus_pos_desktop/application/theme/theme.dart';
import 'package:nativus_pos_desktop/core/enums/tabs_enums.dart';
import 'package:nativus_pos_desktop/features/tables/presentation/widgets/buttons/main_tab_button.dart';
import 'package:nativus_pos_desktop/features/tables/presentation/widgets/status_dot.dart';
import 'package:nativus_pos_desktop/l10n/app_localizations.dart';

class TopBar extends StatelessWidget {
  const TopBar({
    super.key,
    required this.activeTab,
    required this.onTabChanged,
  });

  final TableManagementTab activeTab;
  final ValueChanged<TableManagementTab> onTabChanged;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final localizations = AppLocalizations.of(context)!;

    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 14, 12, 14),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isCompact = constraints.maxWidth < 660;

          final tabButtons = Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              MainTabButton(
                label: localizations.table_management_tables_tab,
                iconData: Icons.table_bar,
                selected: activeTab == TableManagementTab.gestionMesas,
                onTap: () => onTabChanged(TableManagementTab.gestionMesas),
              ),
              const SizedBox(width: 8),
              MainTabButton(
                label: localizations.table_management_salons_tab,
                iconData: Icons.home,
                selected: activeTab == TableManagementTab.salones,
                onTap: () => onTabChanged(TableManagementTab.salones),
              ),
            ],
          );

          final statusLegend = Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              StatusDot(
                color: colorScheme.baseGreen,
                label: localizations.table_management_status_available,
              ),
              const SizedBox(width: 14),
              StatusDot(
                color: colorScheme.redOrange,
                label: localizations.table_management_status_occupied,
              ),
            ],
          );

          if (isCompact) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                tabButtons,
                const SizedBox(height: 12),
                Align(alignment: Alignment.centerRight, child: statusLegend),
              ],
            );
          }

          return Row(children: [tabButtons, const Spacer(), statusLegend]);
        },
      ),
    );
  }
}
