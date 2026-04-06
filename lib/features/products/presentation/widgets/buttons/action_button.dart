import 'package:flutter/material.dart';
import 'package:nativus_pos_desktop/application/theme/theme.dart';

class ActionButton extends StatefulWidget {
  const ActionButton({
    super.key,
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
  State<ActionButton> createState() => _ActionButtonState();
}

class _ActionButtonState extends State<ActionButton> {
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
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
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
                borderRadius: BorderRadius.circular(14),
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
                borderRadius: BorderRadius.circular(14),
                hoverColor: widget.color.withValues(alpha: 0.08),
                splashColor: widget.color.withValues(alpha: 0.16),
                highlightColor: widget.color.withValues(alpha: 0.1),
                child: Icon(widget.icon, color: iconColor, size: 20),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
