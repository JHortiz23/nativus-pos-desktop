import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nativus_pos_desktop/application/theme/theme.dart';
import 'package:nativus_pos_desktop/features/tables/presentation/blocs/tables_bloc.dart';
import 'package:nativus_pos_desktop/features/tables/presentation/widgets/table_management/dining_areas_view.dart';
import 'package:nativus_pos_desktop/features/tables/presentation/widgets/table_management/table_management_models.dart';
import 'package:nativus_pos_desktop/features/tables/presentation/widgets/table_management/table_management_view.dart';
import 'package:nativus_pos_desktop/features/tables/presentation/widgets/table_management/top_bar.dart';
import 'package:nativus_pos_desktop/l10n/app_localizations.dart';

class TableManagementPage extends StatefulWidget {
  const TableManagementPage({super.key});

  @override
  State<TableManagementPage> createState() => _TableManagementPageState();
}

class _TableManagementPageState extends State<TableManagementPage> {
  TableManagementTab _activeTab = TableManagementTab.gestionMesas;
  int? _selectedSalonId; // null = "Todos los Salones"
  late final TablesBloc _bloc;
  late final ScrollController _mesasScrollController;
  late final ScrollController _salonesScrollController;

  @override
  void initState() {
    super.initState();
    _mesasScrollController = ScrollController();
    _salonesScrollController = ScrollController();
    _bloc = context.read<TablesBloc>();
    _bloc.add(const GetDiningAreasEvent());
  }

  @override
  void dispose() {
    _mesasScrollController.dispose();
    _salonesScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final localizations = AppLocalizations.of(context)!;

    return BlocBuilder<TablesBloc, TablesState>(
      builder: (context, state) {
        final diningAreas = mapDiningAreas(state.diningAreas ?? const []);
        final effectiveSelectedSalonId =
            diningAreas.any((area) => area.id == _selectedSalonId)
            ? _selectedSalonId
            : null;

        final totalTables = effectiveSelectedSalonId == null
            ? (state.summary?.totalTables ??
                  diningAreas.fold<int>(
                    0,
                    (sum, area) => sum + area.totalTables,
                  ))
            : diningAreas
                  .firstWhere((area) => area.id == effectiveSelectedSalonId)
                  .totalTables;

        return Container(
          decoration: BoxDecoration(
            color: colorScheme.darkSurface,
            borderRadius: BorderRadius.circular(28),
            border: Border.all(color: colorScheme.softBorder),
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 22, 12, 18),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final isCompactHeader = constraints.maxWidth < 760;
                    final titleBlock = Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          localizations.table_management,
                          style: theme.textTheme.headlineMedium?.copyWith(
                            color: colorScheme.baseWhite,
                            fontSize: 34,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          localizations.table_management_description,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: colorScheme.textMuted,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    );
                    final actionBlock = Flex(
                      direction: isCompactHeader
                          ? Axis.vertical
                          : Axis.horizontal,
                      crossAxisAlignment: isCompactHeader
                          ? CrossAxisAlignment.start
                          : CrossAxisAlignment.center,
                      children: [
                        Text(
                          localizations.table_management_tables_count(
                            totalTables,
                          ),
                          style: theme.textTheme.bodyLarge?.copyWith(
                            color: colorScheme.textSoft,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                          width: isCompactHeader ? 0 : 18,
                          height: isCompactHeader ? 14 : 0,
                        ),
                        FilledButton.icon(
                          onPressed: () {
                            // TODO: implement new table
                          },
                          style: FilledButton.styleFrom(
                            backgroundColor: colorScheme.accentPrimary,
                            foregroundColor: colorScheme.black,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 22,
                              vertical: 18,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            textStyle: theme.textTheme.bodyLarge?.copyWith(
                              fontSize: 15,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          icon: const Icon(Icons.add_rounded),
                          label: Text(
                            _activeTab == TableManagementTab.gestionMesas
                                ? localizations.table_management_new_table
                                : localizations.table_management_new_salon,
                          ),
                        ),
                      ],
                    );

                    if (isCompactHeader) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          titleBlock,
                          const SizedBox(height: 18),
                          actionBlock,
                        ],
                      );
                    }

                    return Row(
                      children: [
                        Expanded(child: titleBlock),
                        const SizedBox(width: 18),
                        actionBlock,
                      ],
                    );
                  },
                ),
              ),
              Divider(
                height: 1,
                color: colorScheme.softBorder.withValues(alpha: 0.7),
              ),
              TopBar(
                activeTab: _activeTab,
                onTabChanged: (tab) => setState(() => _activeTab = tab),
              ),
              Divider(
                height: 1,
                color: colorScheme.softBorder.withValues(alpha: 0.7),
              ),
              Expanded(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 220),
                  child: _activeTab == TableManagementTab.gestionMesas
                      ? TableManagementView(
                          key: const ValueKey('gestion-mesas'),
                          diningAreas: diningAreas,
                          totalTables:
                              state.summary?.totalTables ??
                              diningAreas.fold<int>(
                                0,
                                (sum, area) => sum + area.totalTables,
                              ),
                          selectedSalonId: effectiveSelectedSalonId,
                          onSalonChanged: (id) =>
                              setState(() => _selectedSalonId = id),
                          scrollController: _mesasScrollController,
                        )
                      : DiningAreasView(
                          key: const ValueKey('dining-areas'),
                          diningAreas: diningAreas,
                          scrollController: _salonesScrollController,
                        ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
