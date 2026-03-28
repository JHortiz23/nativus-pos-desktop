import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nativus_pos_desktop/application/application.dart';
import 'package:nativus_pos_desktop/application/theme/theme.dart';
import 'package:nativus_pos_desktop/l10n/app_localizations.dart';

class AppShellPage extends StatefulWidget {
  const AppShellPage({super.key, required this.location, required this.child});

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
                  child: LayoutBuilder(
                    builder: (context, sidebarConstraints) {
                      final showExpandedContent =
                          expanded && sidebarConstraints.maxWidth >= 230;

                      return Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(
                              showExpandedContent ? 18 : 12,
                              18,
                              showExpandedContent ? 18 : 12,
                              18,
                            ),
                            child: showExpandedContent
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
                                              localizations.appTitle
                                                  .toUpperCase(),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headlineSmall
                                                  ?.copyWith(
                                                    color:
                                                        colorScheme.baseWhite,
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.w900,
                                                  ),
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              localizations
                                                  .sidebarBrandSubtitle,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium
                                                  ?.copyWith(
                                                    color:
                                                        colorScheme.textMuted,
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
                                          Icons
                                              .keyboard_double_arrow_left_rounded,
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
                                          Icons
                                              .keyboard_double_arrow_right_rounded,
                                          color: colorScheme.textMuted,
                                        ),
                                      ),
                                    ],
                                  ),
                          ),
                          Divider(
                            height: 1,
                            color: colorScheme.softBorder.withValues(
                              alpha: 0.7,
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: showExpandedContent ? 10 : 8,
                                vertical: 14,
                              ),
                              child: Column(
                                children: [
                                  for (final item
                                      in AppRouter.shellDestinations)
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 8),
                                      child: _SidebarMenuItem(
                                        icon: item.icon,
                                        label: item.label(localizations),
                                        expanded: showExpandedContent,
                                        selected: AppRouter.isRouteSelected(
                                          currentLocation: widget.location,
                                          targetLocation: item.path,
                                        ),
                                        onTap: () => context.go(item.path),
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
                                    expanded: showExpandedContent,
                                    selected: false,
                                    onTap: () => context.go(RoutePaths.login),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Divider(
                            height: 1,
                            color: colorScheme.softBorder.withValues(
                              alpha: 0.7,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(
                              showExpandedContent ? 18 : 12,
                            ),
                            child: _UserCard(expanded: showExpandedContent),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                Expanded(
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 220),
                    curve: Curves.easeOutCubic,
                    margin: EdgeInsets.fromLTRB(0, 12, 0, 12),
                    padding: EdgeInsets.fromLTRB(
                      isCompact ? 6 : 8,
                      0,
                      isCompact ? 6 : 8,
                      0,
                    ),
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
          colors: [colorScheme.accentPrimary, colorScheme.accentPrimaryDark],
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
