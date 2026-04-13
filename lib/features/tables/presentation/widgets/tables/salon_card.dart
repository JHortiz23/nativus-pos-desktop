import 'package:flutter/material.dart';
import 'package:nativus_pos_desktop/application/theme/theme.dart';
import 'package:nativus_pos_desktop/features/tables/presentation/widgets/tables/table_card.dart';
import 'package:nativus_pos_desktop/l10n/app_localizations.dart';

class SalonCard extends StatefulWidget {
  const SalonCard({
    super.key,
    required this.name,
    required this.iconData,
    required this.accentColor,
    required this.totalTables,
    required this.occupiedTables,
    required this.tableNumbers,
    required this.tableStatuses,
    this.onEdit,
    this.onDelete,
  });

  final String name;
  final IconData iconData;
  final Color accentColor;
  final int totalTables;
  final int occupiedTables;
  final List<int> tableNumbers;
  final List<TableStatus> tableStatuses;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  @override
  State<SalonCard> createState() => _SalonCardState();
}

class _SalonCardState extends State<SalonCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    final localizations = AppLocalizations.of(context)!;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOutCubic,
        decoration: BoxDecoration(
          color: colorScheme.darkSurfaceAlt,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: colorScheme.softBorder),
          boxShadow: _isHovered
              ? [
                  BoxShadow(
                    color: widget.accentColor.withValues(alpha: 0.08),
                    blurRadius: 20,
                    spreadRadius: 1,
                  ),
                ]
              : [],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Top accent bar
            Container(
              height: 3.5,
              decoration: BoxDecoration(
                color: widget.accentColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(18),
                  topRight: Radius.circular(18),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 16, 18, 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header row
                  Row(
                    children: [
                      // Salon icon
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: widget.accentColor.withValues(alpha: 0.14),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Center(
                          child: Icon(
                            widget.iconData,
                            size: 24,
                            color: widget.accentColor,
                          ),
                        ),
                      ),
                      const SizedBox(width: 14),
                      // Name and info
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.name,
                              style: theme.textTheme.headlineSmall?.copyWith(
                                color: colorScheme.baseWhite,
                                fontSize: 17,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              localizations.table_management_salon_summary(
                                widget.totalTables,
                                widget.occupiedTables,
                              ),
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: colorScheme.textMuted,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Action buttons
                      _SalonActionButton(
                        icon: Icons.edit_outlined,
                        color: colorScheme.textSoft,
                        background: colorScheme.darkSurface,
                        onTap: widget.onEdit,
                      ),
                      const SizedBox(width: 8),
                      _SalonActionButton(
                        icon: Icons.delete_outline_rounded,
                        color: colorScheme.redOrange,
                        background: colorScheme.redOrange.withValues(
                          alpha: 0.12,
                        ),
                        onTap: widget.onDelete,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Table number indicators
                  Wrap(
                    spacing: 10,
                    runSpacing: 8,
                    children: [
                      for (var i = 0; i < widget.tableNumbers.length; i++)
                        _TableNumberBadge(
                          number: widget.tableNumbers[i],
                          status: widget.tableStatuses[i],
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NewSalonCard extends StatefulWidget {
  const NewSalonCard({super.key, this.onTap});

  final VoidCallback? onTap;

  @override
  State<NewSalonCard> createState() => _NewSalonCardState();
}

class _NewSalonCardState extends State<NewSalonCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    final localizations = AppLocalizations.of(context)!;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOutCubic,
          decoration: BoxDecoration(
            color: colorScheme.darkSurfaceAlt.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: _isHovered
                  ? colorScheme.accentPrimary.withValues(alpha: 0.4)
                  : colorScheme.softBorder.withValues(alpha: 0.5),
              width: 1.5,
            ),
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: colorScheme.accentPrimary.withValues(alpha: 0.06),
                      blurRadius: 20,
                      spreadRadius: 1,
                    ),
                  ]
                : [],
          ),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    color: colorScheme.accentPrimary.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: colorScheme.accentPrimary.withValues(alpha: 0.25),
                    ),
                  ),
                  child: Icon(
                    Icons.add_rounded,
                    color: colorScheme.accentPrimary,
                    size: 28,
                  ),
                ),
                const SizedBox(height: 14),
                Text(
                  localizations.table_management_new_salon,
                  style: theme.textTheme.headlineSmall?.copyWith(
                    color: colorScheme.baseWhite,
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  localizations.table_management_new_salon_description,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: colorScheme.textMuted,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _TableNumberBadge extends StatelessWidget {
  const _TableNumberBadge({required this.number, required this.status});

  final int number;
  final TableStatus status;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    final color = status == TableStatus.ocupada
        ? colorScheme.redOrange
        : colorScheme.baseGreen;

    return Text(
      '$number',
      style: theme.textTheme.bodyLarge?.copyWith(
        color: color,
        fontSize: 15,
        fontWeight: FontWeight.w800,
      ),
    );
  }
}

class _SalonActionButton extends StatefulWidget {
  const _SalonActionButton({
    required this.icon,
    required this.color,
    required this.background,
    this.onTap,
  });

  final IconData icon;
  final Color color;
  final Color background;
  final VoidCallback? onTap;

  @override
  State<_SalonActionButton> createState() => _SalonActionButtonState();
}

class _SalonActionButtonState extends State<_SalonActionButton> {
  bool _isHovered = false;
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isInteractive = widget.onTap != null;
    final emphasis = _isPressed
        ? 0.26
        : _isHovered
        ? 0.18
        : 0.0;
    final backgroundColor = Color.lerp(
      widget.background,
      widget.color,
      emphasis,
    )!;
    final borderColor = Color.lerp(
      colorScheme.softBorder,
      widget.color,
      _isPressed
          ? 0.72
          : _isHovered
          ? 0.55
          : 0.0,
    )!;
    final iconColor = Color.lerp(
      widget.color,
      colorScheme.baseWhite,
      _isPressed
          ? 0.34
          : _isHovered
          ? 0.2
          : 0.0,
    )!;
    final scale = _isPressed
        ? 0.96
        : _isHovered
        ? 1.05
        : 1.0;
    final glowColor = widget.color.withValues(alpha: _isHovered ? 0.16 : 0.0);

    return MouseRegion(
      cursor: isInteractive
          ? SystemMouseCursors.click
          : SystemMouseCursors.basic,
      child: AnimatedScale(
        scale: scale,
        duration: const Duration(milliseconds: 140),
        curve: Curves.easeOutCubic,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 160),
          curve: Curves.easeOutCubic,
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              if (_isHovered)
                BoxShadow(color: glowColor, blurRadius: 14, spreadRadius: 1),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: Ink(
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: borderColor),
              ),
              child: InkWell(
                onTap: widget.onTap,
                onHover: isInteractive
                    ? (value) => setState(() => _isHovered = value)
                    : null,
                onHighlightChanged: isInteractive
                    ? (value) => setState(() => _isPressed = value)
                    : null,
                borderRadius: BorderRadius.circular(12),
                hoverColor: widget.color.withValues(alpha: 0.08),
                splashColor: widget.color.withValues(alpha: 0.16),
                highlightColor: widget.color.withValues(alpha: 0.1),
                child: Icon(widget.icon, color: iconColor, size: 18),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
