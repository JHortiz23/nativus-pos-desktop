import 'package:flutter/material.dart';
import 'package:nativus_pos_desktop/application/theme/theme.dart';
import 'package:nativus_pos_desktop/l10n/app_localizations.dart';

enum TableStatus { disponible, ocupada }

class TableCard extends StatefulWidget {
  const TableCard({
    super.key,
    required this.name,
    required this.capacity,
    required this.status,
    this.onEdit,
    this.onDelete,
  });

  final String name;
  final int capacity;
  final TableStatus status;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  @override
  State<TableCard> createState() => _TableCardState();
}

class _TableCardState extends State<TableCard> {
  bool _isHovered = false;

  Color _statusColor(ColorScheme colorScheme) {
    return switch (widget.status) {
      TableStatus.disponible => colorScheme.baseGreen,
      TableStatus.ocupada => colorScheme.redOrange,
    };
  }

  String _statusLabel(AppLocalizations localizations) {
    return switch (widget.status) {
      TableStatus.disponible => localizations.table_management_status_available,
      TableStatus.ocupada => localizations.table_management_status_occupied,
    };
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    final localizations = AppLocalizations.of(context)!;
    final statusColor = _statusColor(colorScheme);

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOutCubic,
        decoration: BoxDecoration(
          color: colorScheme.darkSurfaceAlt,
          borderRadius: BorderRadius.circular(18),
          border: Border(
            left: BorderSide(
              color: statusColor,
              width: 3.5,
            ),
          ),
          boxShadow: _isHovered
              ? [
                  BoxShadow(
                    color: statusColor.withValues(alpha: 0.12),
                    blurRadius: 16,
                    spreadRadius: 1,
                  ),
                ]
              : [],
        ),
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Table Name
              Text(
                widget.name,
                style: theme.textTheme.headlineMedium?.copyWith(
                  color: colorScheme.baseWhite,
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 6),
              // Capacity
              Row(
                children: [
                  Icon(
                    Icons.people_rounded,
                    size: 14,
                    color: colorScheme.textMuted,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    localizations.table_management_people_count(widget.capacity),
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: colorScheme.textMuted,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              // Status
              Row(
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: statusColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    _statusLabel(localizations),
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: statusColor,
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Action Buttons
              Row(
                children: [
                  _TableActionButton(
                    icon: Icons.edit_outlined,
                    color: colorScheme.textSoft,
                    background: colorScheme.darkSurface,
                    onTap: widget.onEdit,
                  ),
                  const SizedBox(width: 8),
                  _TableActionButton(
                    icon: Icons.delete_outline_rounded,
                    color: colorScheme.redOrange,
                    background:
                        colorScheme.redOrange.withValues(alpha: 0.12),
                    onTap: widget.onDelete,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TableActionButton extends StatefulWidget {
  const _TableActionButton({
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
  State<_TableActionButton> createState() => _TableActionButtonState();
}

class _TableActionButtonState extends State<_TableActionButton> {
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
    final glowColor =
        widget.color.withValues(alpha: _isHovered ? 0.16 : 0.0);

    return MouseRegion(
      cursor:
          isInteractive ? SystemMouseCursors.click : SystemMouseCursors.basic,
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
