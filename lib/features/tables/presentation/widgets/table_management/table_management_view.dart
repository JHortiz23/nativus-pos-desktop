import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:nativus_pos_desktop/application/theme/theme.dart';
import 'package:nativus_pos_desktop/features/tables/presentation/widgets/table_management/dining_area_section.dart';
import 'package:nativus_pos_desktop/features/tables/presentation/widgets/table_management/table_management_models.dart';
import 'package:nativus_pos_desktop/features/tables/presentation/widgets/tables/salon_tab_chip.dart';
import 'package:nativus_pos_desktop/l10n/app_localizations.dart';

class TableManagementView extends StatelessWidget {
  const TableManagementView({
    super.key,
    required this.diningAreas,
    required this.totalTables,
    required this.selectedSalonId,
    required this.onSalonChanged,
    required this.scrollController,
  });

  final List<DiningAreaViewData> diningAreas;
  final int totalTables;
  final int? selectedSalonId;
  final ValueChanged<int?> onSalonChanged;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final localizations = AppLocalizations.of(context)!;
    final accentColor = diningAreaAccentColor(colorScheme);
    final visibleDiningAreas = selectedSalonId == null
        ? diningAreas
        : diningAreas.where((area) => area.id == selectedSalonId).toList();

    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 20, 8, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ScrollConfiguration(
            behavior: const MaterialScrollBehavior().copyWith(
              dragDevices: {
                PointerDeviceKind.touch,
                PointerDeviceKind.mouse,
                PointerDeviceKind.trackpad,
                PointerDeviceKind.stylus,
                PointerDeviceKind.unknown,
              },
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                children: [
                  SalonTabChip(
                    label: localizations.table_management_all_salons,
                    iconData: Icons.home,
                    count: totalTables,
                    selected: selectedSalonId == null,
                    onTap: () => onSalonChanged(null),
                  ),
                  const SizedBox(width: 8),
                  for (final diningArea in diningAreas) ...[
                    SalonTabChip(
                      label: diningArea.name,
                      iconData: Icons.deck,
                      count: diningArea.totalTables,
                      selected: selectedSalonId == diningArea.id,
                      accentColor: accentColor,
                      onTap: () => onSalonChanged(diningArea.id),
                    ),
                    const SizedBox(width: 8),
                  ],
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: RawScrollbar(
              controller: scrollController,
              thumbVisibility: true,
              trackVisibility: true,
              thumbColor: colorScheme.textSoft.withValues(alpha: 0.2),
              trackColor: colorScheme.textSoft.withValues(alpha: 0.08),
              trackBorderColor: colorScheme.transparent,
              radius: const Radius.circular(999),
              trackRadius: const Radius.circular(999),
              thickness: 6,
              crossAxisMargin: 2,
              child: SingleChildScrollView(
                controller: scrollController,
                padding: const EdgeInsets.only(right: 14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (final diningArea in visibleDiningAreas) ...[
                      DiningAreaSection(diningArea: diningArea),
                      const SizedBox(height: 28),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
