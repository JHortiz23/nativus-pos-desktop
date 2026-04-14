import 'package:flutter/material.dart';
import 'package:nativus_pos_desktop/application/theme/theme.dart';

class MainTabButton extends StatelessWidget {
  const MainTabButton({
    super.key,
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
