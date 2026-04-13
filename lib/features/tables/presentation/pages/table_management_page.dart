import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nativus_pos_desktop/application/theme/theme.dart';
import 'package:nativus_pos_desktop/features/tables/presentation/blocs/tables_bloc.dart';
import 'package:nativus_pos_desktop/features/tables/presentation/widgets/tables/salon_card.dart';
import 'package:nativus_pos_desktop/features/tables/presentation/widgets/tables/salon_tab_chip.dart';
import 'package:nativus_pos_desktop/features/tables/presentation/widgets/tables/table_card.dart';
import 'package:nativus_pos_desktop/l10n/app_localizations.dart';

// ─── Mock Data ──────────────────────────────────────────────────────────────

class _MockTable {
  const _MockTable({
    required this.id,
    required this.number,
    required this.capacity,
    required this.status,
    required this.salonId,
  });

  final int id;
  final int number;
  final int capacity;
  final TableStatus status;
  final int salonId;
}

class _MockSalon {
  const _MockSalon({
    required this.id,
    required this.icon,
    required this.accentColor,
  });

  final int id;
  final String icon;
  final Color accentColor;
}

const _mockSalons = <_MockSalon>[
  _MockSalon(id: 1, icon: '🏠', accentColor: Color(0xFFF0A45F)),
  _MockSalon(id: 2, icon: '⭐', accentColor: Color(0xFF65C466)),
  _MockSalon(id: 3, icon: '🌿', accentColor: Color(0xFF5B8DEF)),
];

const _mockTables = <_MockTable>[
  // Salón Principal (5 mesas)
  _MockTable(
    id: 1,
    number: 1,
    capacity: 2,
    status: TableStatus.disponible,
    salonId: 1,
  ),
  _MockTable(
    id: 2,
    number: 2,
    capacity: 4,
    status: TableStatus.ocupada,
    salonId: 1,
  ),
  _MockTable(
    id: 3,
    number: 3,
    capacity: 4,
    status: TableStatus.disponible,
    salonId: 1,
  ),
  _MockTable(
    id: 4,
    number: 4,
    capacity: 6,
    status: TableStatus.disponible,
    salonId: 1,
  ),
  _MockTable(
    id: 5,
    number: 5,
    capacity: 8,
    status: TableStatus.disponible,
    salonId: 1,
  ),
  // Salón VIP (3 mesas)
  _MockTable(
    id: 6,
    number: 6,
    capacity: 2,
    status: TableStatus.disponible,
    salonId: 2,
  ),
  _MockTable(
    id: 7,
    number: 7,
    capacity: 4,
    status: TableStatus.ocupada,
    salonId: 2,
  ),
  _MockTable(
    id: 8,
    number: 8,
    capacity: 6,
    status: TableStatus.disponible,
    salonId: 2,
  ),
  // Terraza (3 mesas)
  _MockTable(
    id: 9,
    number: 9,
    capacity: 2,
    status: TableStatus.disponible,
    salonId: 3,
  ),
  _MockTable(
    id: 10,
    number: 10,
    capacity: 4,
    status: TableStatus.disponible,
    salonId: 3,
  ),
  _MockTable(
    id: 11,
    number: 11,
    capacity: 4,
    status: TableStatus.ocupada,
    salonId: 3,
  ),
];

String _salonName(AppLocalizations localizations, int salonId) {
  return switch (salonId) {
    1 => localizations.table_management_salon_main,
    2 => localizations.table_management_salon_vip,
    3 => localizations.table_management_salon_terrace,
    _ => localizations.table_management_salons_tab,
  };
}

// ─── Page ───────────────────────────────────────────────────────────────────

enum _MainTab { gestionMesas, salones }

class TableManagementPage extends StatefulWidget {
  const TableManagementPage({super.key});

  @override
  State<TableManagementPage> createState() => _TableManagementPageState();
}

class _TableManagementPageState extends State<TableManagementPage> {
  _MainTab _activeTab = _MainTab.gestionMesas;
  int? _selectedSalonId; // null = "Todos los Salones"
  // set table bloc
  late final TablesBloc _bloc;
  late final ScrollController _mesasScrollController;
  late final ScrollController _salonesScrollController;

  @override
  void initState() {
    super.initState();
    _mesasScrollController = ScrollController();
    _salonesScrollController = ScrollController();
    _bloc = context.read<TablesBloc>();
    _bloc.add(GetDiningAreasEvent());
    final diningAreas = _bloc.state.diningAreas;
    final summary = _bloc.state.summary;

    if (diningAreas == null || summary == null) {
      _bloc.add(GetDiningAreasEvent());
    }
  }

  @override
  void dispose() {
    _mesasScrollController.dispose();
    _salonesScrollController.dispose();
    super.dispose();
  }

  List<_MockTable> get _filteredTables {
    if (_selectedSalonId == null) return _mockTables;
    return _mockTables.where((t) => t.salonId == _selectedSalonId).toList();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    final localizations = AppLocalizations.of(context)!;
    final totalTables = _mockTables.length;

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.darkSurface,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: colorScheme.softBorder),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          // ── Header ──
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
                  direction: isCompactHeader ? Axis.vertical : Axis.horizontal,
                  crossAxisAlignment: isCompactHeader
                      ? CrossAxisAlignment.start
                      : CrossAxisAlignment.center,
                  children: [
                    Text(
                      localizations.table_management_tables_count(totalTables),
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
          // ── Tab bar ──
          _TopBar(
            activeTab: _activeTab,
            onTabChanged: (tab) => setState(() => _activeTab = tab),
          ),
          Divider(
            height: 1,
            color: colorScheme.softBorder.withValues(alpha: 0.7),
          ),
          // ── Content ──
          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 220),
              child: _activeTab == _MainTab.gestionMesas
                  ? _GestionMesasView(
                      key: const ValueKey('gestion-mesas'),
                      selectedSalonId: _selectedSalonId,
                      onSalonChanged: (id) =>
                          setState(() => _selectedSalonId = id),
                      filteredTables: _filteredTables,
                      scrollController: _mesasScrollController,
                    )
                  : _SalonesView(
                      key: const ValueKey('salones'),
                      scrollController: _salonesScrollController,
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Top Bar ────────────────────────────────────────────────────────────────

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
                icon: '🏠',
                selected: activeTab == _MainTab.gestionMesas,
                onTap: () => onTabChanged(_MainTab.gestionMesas),
              ),
              const SizedBox(width: 8),
              _MainTabButton(
                label: localizations.table_management_salons_tab,
                icon: '🏘️',
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
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final String icon;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = Theme.of(context).colorScheme;

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
              Text(icon, style: const TextStyle(fontSize: 16)),
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

// ─── Gestión de Mesas View ──────────────────────────────────────────────────

class _GestionMesasView extends StatelessWidget {
  const _GestionMesasView({
    super.key,
    required this.selectedSalonId,
    required this.onSalonChanged,
    required this.filteredTables,
    required this.scrollController,
  });

  final int? selectedSalonId;
  final ValueChanged<int?> onSalonChanged;
  final List<_MockTable> filteredTables;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final localizations = AppLocalizations.of(context)!;

    // Group tables by salon
    final groupedBySalon = <int, List<_MockTable>>{};
    for (final table in filteredTables) {
      groupedBySalon.putIfAbsent(table.salonId, () => []).add(table);
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 20, 8, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Salon filter tabs ──
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
                    icon: '🏠',
                    count: _mockTables.length,
                    selected: selectedSalonId == null,
                    onTap: () => onSalonChanged(null),
                  ),
                  const SizedBox(width: 8),
                  for (final salon in _mockSalons) ...[
                    SalonTabChip(
                      label: _salonName(localizations, salon.id),
                      icon: salon.icon,
                      count: _mockTables
                          .where((t) => t.salonId == salon.id)
                          .length,
                      selected: selectedSalonId == salon.id,
                      accentColor: salon.accentColor,
                      onTap: () => onSalonChanged(salon.id),
                    ),
                    const SizedBox(width: 8),
                  ],
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          // ── Tables content ──
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
                    for (final salonId in groupedBySalon.keys) ...[
                      _SalonSection(
                        salon: _mockSalons.firstWhere((s) => s.id == salonId),
                        tables: groupedBySalon[salonId]!,
                      ),
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

// ─── Salon Section (Gestión de Mesas) ───────────────────────────────────────

class _SalonSection extends StatelessWidget {
  const _SalonSection({required this.salon, required this.tables});

  final _MockSalon salon;
  final List<_MockTable> tables;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    final localizations = AppLocalizations.of(context)!;
    final available = tables
        .where((t) => t.status == TableStatus.disponible)
        .length;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Salon header
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Row(
            children: [
              Text(salon.icon, style: const TextStyle(fontSize: 22)),
              const SizedBox(width: 10),
              Text(
                _salonName(localizations, salon.id),
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
                  localizations.table_management_tables_count(tables.length),
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: colorScheme.textMuted,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const Spacer(),
              Text(
                localizations.table_management_available_count(available),
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: colorScheme.textMuted,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        // Tables grid
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
                for (final table in tables)
                  SizedBox(
                    width:
                        (maxWidth - (crossAxisCount - 1) * 14) / crossAxisCount,
                    child: TableCard(
                      name: localizations.table_management_table_name(
                        table.number,
                      ),
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

// ─── Salones View ───────────────────────────────────────────────────────────

class _SalonesView extends StatelessWidget {
  const _SalonesView({super.key, required this.scrollController});

  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final localizations = AppLocalizations.of(context)!;

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

              final salonCards = <Widget>[
                for (final salon in _mockSalons)
                  _buildSalonCard(localizations, salon, itemWidth),
              ];

              return Wrap(spacing: 16, runSpacing: 16, children: salonCards);
            },
          ),
        ),
      ),
    );
  }

  Widget _buildSalonCard(
    AppLocalizations localizations,
    _MockSalon salon,
    double width,
  ) {
    final salonTables = _mockTables
        .where((t) => t.salonId == salon.id)
        .toList();
    final occupied = salonTables
        .where((t) => t.status == TableStatus.ocupada)
        .length;

    return SizedBox(
      width: width,
      child: SalonCard(
        name: _salonName(localizations, salon.id),
        icon: salon.icon,
        accentColor: salon.accentColor,
        totalTables: salonTables.length,
        occupiedTables: occupied,
        tableNumbers: salonTables.map((t) => t.number).toList(),
        tableStatuses: salonTables.map((t) => t.status).toList(),
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
