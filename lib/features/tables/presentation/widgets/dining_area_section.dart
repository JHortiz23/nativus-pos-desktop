import 'package:flutter/material.dart';
import 'package:nativus_pos_desktop/application/theme/theme.dart';
import 'package:nativus_pos_desktop/features/tables/domain/entities/dining_area_entity.dart';
import 'package:nativus_pos_desktop/features/tables/presentation/helpers/table_management_helpers.dart';
import 'package:nativus_pos_desktop/features/tables/presentation/widgets/cards/table_card.dart';
import 'package:nativus_pos_desktop/features/tables/presentation/widgets/dialogs/add_table_dialog.dart';
import 'package:nativus_pos_desktop/l10n/app_localizations.dart';

class DiningAreaSection extends StatelessWidget {
  const DiningAreaSection({super.key, required this.diningArea});

  final DiningAreaEntity diningArea;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final localizations = AppLocalizations.of(context)!;
    final accentColor = diningAreaAccentColor(colorScheme);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Row(
            children: [
              Icon(Icons.deck, size: 22, color: accentColor),
              const SizedBox(width: 10),
              Text(
                diningArea.name,
                style: theme.textTheme.headlineSmall?.copyWith(
                  color: colorScheme.baseWhite,
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(width: 10),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: colorScheme.darkSurfaceAlt,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  localizations.table_management_tables_count(
                    diningArea.tablesCount,
                  ),
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: colorScheme.textMuted,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const Spacer(),
              Text(
                localizations.table_management_available_count(
                  diningArea.availableCount,
                ),
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: colorScheme.textMuted,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        LayoutBuilder(
          builder: (context, constraints) {
            final maxWidth = constraints.maxWidth;
            final crossAxisCount = maxWidth > 900
                ? 4
                : maxWidth > 640
                ? 3
                : maxWidth > 400
                ? 2
                : 1;

            return Wrap(
              spacing: 14,
              runSpacing: 14,
              children: [
                for (final table in diningArea.tables)
                  SizedBox(
                    width:
                        (maxWidth - (crossAxisCount - 1) * 14) / crossAxisCount,
                    child: TableCard(
                      name: displayTableName(table, localizations),
                      capacity: table.seats ?? 0,
                      status: tableStatus(table),
                      onEdit: () {
                        // TODO: implement edit
                        showDialog(
                          context: context,
                          builder: (context) => const AddTableDialog(),
                        );
                      },
                      onDelete: () {
                        // TODO: implement delete
                      },
                    ),
                  ),
              ],
            );
          },
        ),
      ],
    );
  }
}
