import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nativus_pos_desktop/application/theme/theme.dart';
import 'package:nativus_pos_desktop/features/tables/domain/entities/dining_area_entity.dart';
import 'package:nativus_pos_desktop/features/tables/presentation/blocs/tables_bloc.dart';
import 'package:nativus_pos_desktop/features/tables/presentation/helpers/table_management_helpers.dart';
import 'package:nativus_pos_desktop/features/tables/presentation/widgets/cards/dining_area_card.dart';
import 'package:nativus_pos_desktop/features/tables/presentation/widgets/dialogs/add_diningarea_dialog.dart';
import 'package:nativus_pos_desktop/l10n/app_localizations.dart';
import 'package:nativus_pos_desktop/shared/widgets/dialogs/app_confirmation_dialog.dart';

class DiningAreasView extends StatelessWidget {
  const DiningAreasView({
    super.key,
    required this.diningAreas,
    required this.scrollController,
  });

  final List<DiningAreaEntity> diningAreas;
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

  final DiningAreaEntity diningArea;
  final double width;

  @override
  Widget build(BuildContext context) {
    final accentColor = diningAreaAccentColor(Theme.of(context).colorScheme);

    return SizedBox(
      width: width,
      child: DiningAreaCard(
        name: diningArea.name,
        iconData: Icons.deck,
        accentColor: accentColor,
        totalTables: diningArea.tablesCount,
        occupiedTables: diningArea.occupiedCount,
        tableNumbers: diningArea.tables.map(tableNumber).toList(),
        tableStatuses: diningArea.tables.map(tableStatus).toList(),
        onEdit: () {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => BlocProvider.value(
              value: context.read<TablesBloc>(),
              child: AddDiningAreaDialog(diningArea: diningArea),
            ),
          );
        },
        onDelete: () {
          _confirmDeleteDiningArea(context, diningArea.id);
        },
      ),
    );
  }

  Future<void> _confirmDeleteDiningArea(
    BuildContext context,
    int diningAreaId,
  ) async {
    final localizations = AppLocalizations.of(context)!;
    final shouldDelete = await showAppConfirmationDialog(
      context: context,
      title: localizations.delete_salon_dialog_title,
      message: localizations.delete_salon_dialog_message,
      confirmLabel: localizations.delete_action,
    );

    if (shouldDelete != true || !context.mounted) {
      return;
    }

    context.read<TablesBloc>().add(DeleteDiningAreaEvent(id: diningAreaId));
  }
}
