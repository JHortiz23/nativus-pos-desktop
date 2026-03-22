import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nativus_pos_desktop/application/theme/theme.dart';
import 'package:nativus_pos_desktop/core/enums/sidebar_options_enum.dart';
import 'package:nativus_pos_desktop/l10n/app_localizations.dart';

class AppShellPage extends StatefulWidget {
  const AppShellPage({
    super.key,
    required this.location,
    required this.child,
  });

  final String location;
  final Widget child;

  @override
  State<AppShellPage> createState() => _AppShellPageState();
}

class _AppShellPageState extends State<AppShellPage> {
  bool? _isExpanded;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final localizations = AppLocalizations.of(context)!;

    return LayoutBuilder(
      builder: (context, constraints) {
        final isCompact = constraints.maxWidth < 940;
        final expanded = _isExpanded ?? !isCompact;
        final sidebarWidth = expanded ? 278.0 : 88.0;

        return Scaffold(
          backgroundColor: colorScheme.darkBackground,
          body: SafeArea(
            child: Row(
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 220),
                  curve: Curves.easeOutCubic,
                  width: sidebarWidth,
                  margin: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: colorScheme.darkSurface,
                    borderRadius: BorderRadius.circular(28),
                    border: Border.all(color: colorScheme.softBorder),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                          expanded ? 18 : 12,
                          18,
                          expanded ? 18 : 12,
                          18,
                        ),
                        child: expanded
                            ? Row(
                                children: [
                                  const _SidebarLogo(compact: false),
                                  const SizedBox(width: 14),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          localizations.appTitle.toUpperCase(),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineSmall
                                              ?.copyWith(
                                                color: colorScheme.baseWhite,
                                                fontSize: 17,
                                                fontWeight: FontWeight.w900,
                                              ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          localizations.sidebarBrandSubtitle,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium
                                              ?.copyWith(
                                                color: colorScheme.textMuted,
                                                fontSize: 13,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        _isExpanded = false;
                                      });
                                    },
                                    tooltip: localizations.sidebarCollapse,
                                    icon: Icon(
                                      Icons.keyboard_double_arrow_left_rounded,
                                      color: colorScheme.textMuted,
                                    ),
                                  ),
                                ],
                              )
                            : Column(
                                children: [
                                  const _SidebarLogo(compact: true),
                                  const SizedBox(height: 12),
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        _isExpanded = true;
                                      });
                                    },
                                    tooltip: localizations.sidebarExpand,
                                    icon: Icon(
                                      Icons.keyboard_double_arrow_right_rounded,
                                      color: colorScheme.textMuted,
                                    ),
                                  ),
                                ],
                              ),
                      ),
                      Divider(
                        height: 1,
                        color: colorScheme.softBorder.withValues(alpha: 0.7),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: expanded ? 10 : 8,
                            vertical: 14,
                          ),
                          child: Column(
                            children: [
                              for (final item in _buildMenu(localizations))
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 8),
                                  child: _SidebarMenuItem(
                                    icon: item.icon,
                                    label: item.label,
                                    expanded: expanded,
                                    selected: widget.location == item.route,
                                    onTap: () => context.go(item.route),
                                  ),
                                ),
                              const Spacer(),
                              Divider(
                                height: 1,
                                color: colorScheme.softBorder.withValues(
                                  alpha: 0.7,
                                ),
                              ),
                              const SizedBox(height: 14),
                              _SidebarMenuItem(
                                icon: Icons.logout_rounded,
                                label: localizations.sidebarLogout,
                                expanded: expanded,
                                selected: false,
                                onTap: () => context.go('/'),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Divider(
                        height: 1,
                        color: colorScheme.softBorder.withValues(alpha: 0.7),
                      ),
                      Padding(
                        padding: EdgeInsets.all(expanded ? 18 : 12),
                        child: _UserCard(expanded: expanded),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 220),
                    curve: Curves.easeOutCubic,
                    margin: EdgeInsets.fromLTRB(0, 12, 12, 12),
                    padding: EdgeInsets.all(isCompact ? 18 : 24),
                    decoration: BoxDecoration(
                      color: colorScheme.darkBackground,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: widget.child,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  List<_ShellMenuDestination> _buildMenu(AppLocalizations localizations) {
    return [
      _ShellMenuDestination(
        section: MenuSection.dashboard,
        icon: Icons.home_outlined,
        label: localizations.sidebarDashboard,
        route: '/app/dashboard',
      ),
      _ShellMenuDestination(
        section: MenuSection.pointOfSale,
        icon: Icons.attach_money_rounded,
        label: localizations.sidebarPointOfSale,
        route: '/app/point-of-sale',
      ),
      _ShellMenuDestination(
        section: MenuSection.tableManagement,
        icon: Icons.table_restaurant_outlined,
        label: localizations.sidebarTableManagement,
        route: '/app/table-management',
      ),
      _ShellMenuDestination(
        section: MenuSection.products,
        icon: Icons.inventory_2_outlined,
        label: localizations.sidebarProducts,
        route: '/app/products',
      ),
      _ShellMenuDestination(
        section: MenuSection.reports,
        icon: Icons.bar_chart_rounded,
        label: localizations.sidebarReports,
        route: '/app/reports',
      ),
      _ShellMenuDestination(
        section: MenuSection.settings,
        icon: Icons.settings_outlined,
        label: localizations.sidebarSettings,
        route: '/app/settings',
      ),
    ];
  }
}

class _SidebarLogo extends StatelessWidget {
  const _SidebarLogo({required this.compact});

  final bool compact;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: compact ? 48 : 52,
      height: compact ? 48 : 52,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            colorScheme.accentPrimary,
            colorScheme.accentPrimaryDark,
          ],
        ),
      ),
      child: Icon(
        Icons.eco_rounded,
        color: colorScheme.darkSurface,
        size: compact ? 24 : 28,
      ),
    );
  }
}

class _SidebarMenuItem extends StatelessWidget {
  const _SidebarMenuItem({
    required this.icon,
    required this.label,
    required this.expanded,
    required this.selected,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool expanded;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final foreground = selected
        ? colorScheme.accentPrimary
        : colorScheme.textSoft;
    final background = selected
        ? colorScheme.accentPrimary.withValues(alpha: 0.22)
        : Colors.transparent;

    return Material(
      color: background,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: SizedBox(
          height: 56,
          child: expanded
              ? Row(
                  children: [
                    const SizedBox(width: 14),
                    Icon(icon, color: foreground, size: 24),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Text(
                        label,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: foreground,
                          fontSize: 15,
                          fontWeight: selected
                              ? FontWeight.w700
                              : FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(width: 14),
                  ],
                )
              : Center(child: Icon(icon, color: foreground, size: 24)),
        ),
      ),
    );
  }
}

class _UserCard extends StatelessWidget {
  const _UserCard({required this.expanded});

  final bool expanded;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final localizations = AppLocalizations.of(context)!;

    if (!expanded) {
      return Center(
        child: Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: colorScheme.accentPrimary.withValues(alpha: 0.28),
            borderRadius: BorderRadius.circular(14),
          ),
          alignment: Alignment.center,
          child: Text(
            'A',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: colorScheme.accentPrimary,
              fontSize: 20,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      );
    }

    return Row(
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: colorScheme.accentPrimary.withValues(alpha: 0.28),
            borderRadius: BorderRadius.circular(14),
          ),
          alignment: Alignment.center,
          child: Text(
            'A',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: colorScheme.accentPrimary,
              fontSize: 20,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                localizations.sidebarAdminName,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: colorScheme.baseWhite,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                localizations.sidebarAdminRole,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: colorScheme.textMuted,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ShellMenuDestination {
  const _ShellMenuDestination({
    required this.section,
    required this.icon,
    required this.label,
    required this.route,
  });

  final MenuSection section;
  final IconData icon;
  final String label;
  final String route;
}
