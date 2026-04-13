import 'package:flutter/material.dart';
import 'package:nativus_pos_desktop/application/theme/theme.dart';

class SalonTabChip extends StatelessWidget {
  const SalonTabChip({
    super.key,
    required this.label,
    required this.iconData,
    required this.count,
    required this.selected,
    required this.onTap,
    this.accentColor,
  });

  final String label;
  final IconData iconData;
  final int count;
  final bool selected;
  final VoidCallback onTap;
  final Color? accentColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    final effectiveAccent = accentColor ?? colorScheme.accentPrimary;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        hoverColor: colorScheme.softBorder.withValues(alpha: 0.3),
        splashColor: effectiveAccent.withValues(alpha: 0.1),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: selected ? effectiveAccent : colorScheme.transparent,
                width: 2.5,
              ),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                iconData,
                size: 18,
                color: selected ? effectiveAccent : colorScheme.textSoft,
              ),
              const SizedBox(width: 8),
              Text(
                label,
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: selected ? effectiveAccent : colorScheme.textSoft,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: selected
                      ? effectiveAccent.withValues(alpha: 0.18)
                      : colorScheme.darkSurfaceAlt,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  '$count',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: selected ? effectiveAccent : colorScheme.textMuted,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
