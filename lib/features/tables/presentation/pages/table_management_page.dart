import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nativus_pos_desktop/application/theme/theme.dart';
import 'package:nativus_pos_desktop/features/tables/domain/entities/dining_area_entity.dart';
import 'package:nativus_pos_desktop/features/tables/domain/entities/table_entity.dart';
import 'package:nativus_pos_desktop/features/tables/presentation/blocs/tables_bloc.dart';
import 'package:nativus_pos_desktop/features/tables/presentation/widgets/tables/salon_card.dart';
import 'package:nativus_pos_desktop/features/tables/presentation/widgets/tables/salon_tab_chip.dart';
import 'package:nativus_pos_desktop/features/tables/presentation/widgets/tables/table_card.dart';
import 'package:nativus_pos_desktop/l10n/app_localizations.dart';

enum _MainTab { gestionMesas, salones }

const IconData _diningAreaIconData = Icons.deck;

class TableManagementPage extends StatefulWidget {
  const TableManagementPage({super.key});

  @override
  State<TableManagementPage> createState() => _TableManagementPageState();
}

class _TableManagementPageState extends State<TableManagementPage> {
  _MainTab _activeTab = _MainTab.gestionMesas;
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
    //Get dining areas with tables
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
        final diningAreas = _mapDiningAreas(state.diningAreas ?? const []);
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
                            _activeTab == _MainTab.gestionMesas
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
              _TopBar(
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
                  child: _activeTab == _MainTab.gestionMesas
                      ? _GestionMesasView(
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
                      : _SalonesView(
                          key: const ValueKey('salones'),
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

class _TopBar extends StatelessWidget {
  const _TopBar({required this.activeTab, required this.onTabChanged});

  final _MainTab activeTab;
  final ValueChanged<_MainTab> onTabChanged;

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
              _MainTabButton(
                label: localizations.table_management_tables_tab,
                iconData: Icons.table_bar,
                selected: activeTab == _MainTab.gestionMesas,
                onTap: () => onTabChanged(_MainTab.gestionMesas),
              ),
              const SizedBox(width: 8),
              _MainTabButton(
                label: localizations.table_management_salons_tab,
                iconData: Icons.home,
                selected: activeTab == _MainTab.salones,
                onTap: () => onTabChanged(_MainTab.salones),
              ),
            ],
          );

          final statusLegend = Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _StatusDot(
                color: colorScheme.baseGreen,
                label: localizations.table_management_status_available,
              ),
              const SizedBox(width: 14),
              _StatusDot(
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

class _MainTabButton extends StatelessWidget {
  const _MainTabButton({
    required this.label,
    required this.iconData,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final IconData iconData;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Material(
      color: selected
          ? colorScheme.accentPrimary.withValues(alpha: 0.18)
          : Colors.transparent,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        hoverColor: colorScheme.accentPrimary.withValues(alpha: 0.08),
        splashColor: colorScheme.accentPrimary.withValues(alpha: 0.12),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                iconData,
                size: 18,
                color: selected
                    ? colorScheme.accentPrimary
                    : colorScheme.textSoft,
              ),
              const SizedBox(width: 8),
              Text(
                label,
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: selected
                      ? colorScheme.accentPrimary
                      : colorScheme.textSoft,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatusDot extends StatelessWidget {
  const _StatusDot({required this.color, required this.label});

  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: colorScheme.textSoft,
            fontSize: 13,
          ),
        ),
      ],
    );
  }
}

class _GestionMesasView extends StatelessWidget {
  const _GestionMesasView({
    super.key,
    required this.diningAreas,
    required this.totalTables,
    required this.selectedSalonId,
    required this.onSalonChanged,
    required this.scrollController,
  });

  final List<_DiningAreaViewData> diningAreas;
  final int totalTables;
  final int? selectedSalonId;
  final ValueChanged<int?> onSalonChanged;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final localizations = AppLocalizations.of(context)!;
    final accentColor = _diningAreaAccentColor(colorScheme);
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
                      iconData: _diningAreaIconData,
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
                      _SalonSection(salon: diningArea),
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

class _SalonSection extends StatelessWidget {
  const _SalonSection({required this.salon});

  final _DiningAreaViewData salon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final localizations = AppLocalizations.of(context)!;
    final accentColor = _diningAreaAccentColor(colorScheme);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Row(
            children: [
              Icon(_diningAreaIconData, size: 22, color: accentColor),
              const SizedBox(width: 10),
              Text(
                salon.name,
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
                    salon.totalTables,
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
                  salon.availableCount,
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
                for (final table in salon.tables)
                  SizedBox(
                    width:
                        (maxWidth - (crossAxisCount - 1) * 14) / crossAxisCount,
                    child: TableCard(
                      name: table.displayName(localizations),
                      capacity: table.capacity,
                      status: table.status,
                      onEdit: () {
                        // TODO: implement edit
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

class _SalonesView extends StatelessWidget {
  const _SalonesView({
    super.key,
    required this.diningAreas,
    required this.scrollController,
  });

  final List<_DiningAreaViewData> diningAreas;
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
                    _buildSalonCard(context, diningArea, itemWidth),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildSalonCard(
    BuildContext context,
    _DiningAreaViewData diningArea,
    double width,
  ) {
    final accentColor = _diningAreaAccentColor(Theme.of(context).colorScheme);

    return SizedBox(
      width: width,
      child: SalonCard(
        name: diningArea.name,
        iconData: _diningAreaIconData,
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

class _DiningAreaViewData {
  const _DiningAreaViewData({
    required this.id,
    required this.name,
    required this.totalTables,
    required this.availableCount,
    required this.occupiedCount,
    required this.tables,
  });

  final int id;
  final String name;
  final int totalTables;
  final int availableCount;
  final int occupiedCount;
  final List<_TableViewData> tables;
}

class _TableViewData {
  const _TableViewData({
    required this.id,
    required this.name,
    required this.number,
    required this.hasExtractedNumber,
    required this.capacity,
    required this.status,
  });

  final int id;
  final String name;
  final int number;
  final bool hasExtractedNumber;
  final int capacity;
  final TableStatus status;

  String displayName(AppLocalizations localizations) {
    if (hasExtractedNumber || name.trim().isEmpty) {
      return localizations.table_management_table_name(number);
    }
    return name;
  }
}

List<_DiningAreaViewData> _mapDiningAreas(List<DiningAreaEntity> diningAreas) {
  return diningAreas.map(_mapDiningArea).toList(growable: false);
}

_DiningAreaViewData _mapDiningArea(DiningAreaEntity diningArea) {
  return _DiningAreaViewData(
    id: diningArea.id,
    name: diningArea.name,
    totalTables: diningArea.tablesCount,
    availableCount: diningArea.availableCount,
    occupiedCount: diningArea.occupiedCount,
    tables: diningArea.tables.map(_mapTable).toList(growable: false),
  );
}

_TableViewData _mapTable(TableEntity table) {
  final extractedNumber = _extractTableNumber(table.name);

  return _TableViewData(
    id: table.id,
    name: table.name,
    number: extractedNumber ?? table.id,
    hasExtractedNumber: extractedNumber != null,
    capacity: table.seats ?? 0,
    status: _mapTableStatus(table.status),
  );
}

int? _extractTableNumber(String value) {
  final matches = RegExp(r'\d+').allMatches(value).toList(growable: false);
  if (matches.isEmpty) {
    return null;
  }

  return int.tryParse(matches.last.group(0) ?? '');
}

TableStatus _mapTableStatus(String status) {
  final normalized = status.trim().toLowerCase();
  const availableKeywords = {'available', 'disponible', 'free', 'open'};

  if (availableKeywords.any(normalized.contains)) {
    return TableStatus.disponible;
  }

  return TableStatus.ocupada;
}

Color _diningAreaAccentColor(ColorScheme colorScheme) {
  return colorScheme.accentPrimary;
}
