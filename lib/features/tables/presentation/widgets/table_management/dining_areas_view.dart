import 'package:flutter/material.dart';
import 'package:nativus_pos_desktop/application/theme/theme.dart';
import 'package:nativus_pos_desktop/features/tables/presentation/widgets/table_management/table_management_models.dart';
import 'package:nativus_pos_desktop/features/tables/presentation/widgets/tables/salon_card.dart';

class DiningAreasView extends StatelessWidget {
  const DiningAreasView({
    super.key,
    required this.diningAreas,
    required this.scrollController,
  });

  final List<DiningAreaViewData> diningAreas;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 0, 8, 24),
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
          child: LayoutBuilder(
            builder: (context, constraints) {
              final maxWidth = constraints.maxWidth;
              final crossAxisCount = maxWidth > 700 ? 2 : 1;
              final itemWidth =
                  (maxWidth - (crossAxisCount - 1) * 16) / crossAxisCount;

              return Wrap(
                spacing: 16,
                runSpacing: 16,
                children: [
                  for (final diningArea in diningAreas)
                    _DiningAreaCard(diningArea: diningArea, width: itemWidth),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _DiningAreaCard extends StatelessWidget {
  const _DiningAreaCard({required this.diningArea, required this.width});

  final DiningAreaViewData diningArea;
  final double width;

  @override
  Widget build(BuildContext context) {
    final accentColor = diningAreaAccentColor(Theme.of(context).colorScheme);

    return SizedBox(
      width: width,
      child: SalonCard(
        name: diningArea.name,
        iconData: Icons.deck,
        accentColor: accentColor,
        totalTables: diningArea.totalTables,
        occupiedTables: diningArea.occupiedCount,
        tableNumbers: diningArea.tables.map((table) => table.number).toList(),
        tableStatuses: diningArea.tables.map((table) => table.status).toList(),
        onEdit: () {
          // TODO: implement edit
        },
        onDelete: () {
          // TODO: implement delete
        },
      ),
    );
  }
}
