import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nativus_pos_desktop/application/theme/theme.dart';

class AppToast {
  static OverlayEntry? _currentEntry;
  static AnimationController? _currentController;
  static Timer? _dismissTimer;

  static Future<void> show(
    BuildContext context, {
    required String message,
    required Color borderColor,
    Duration duration = const Duration(seconds: 3),
  }) async {
    final overlay = Overlay.of(context, rootOverlay: true);

    await _removeCurrentToast(immediate: true);

    final controller = AnimationController(
      vsync: overlay,
      duration: const Duration(milliseconds: 320),
      reverseDuration: const Duration(milliseconds: 260),
    );

    final animation = CurvedAnimation(
      parent: controller,
      curve: Curves.easeOutQuint,
      reverseCurve: Curves.easeInCubic,
    );

    late final OverlayEntry entry;
    entry = OverlayEntry(
      builder: (_) => _AppToastOverlay(
        animation: animation,
        message: message,
        borderColor: borderColor,
      ),
    );

    _currentEntry = entry;
    _currentController = controller;
    overlay.insert(entry);

    await controller.forward();

    _dismissTimer = Timer(duration, () async {
      if (_currentEntry != entry) {
        return;
      }

      await _removeCurrentToast();
    });
  }

  static Future<void> hide() => _removeCurrentToast();

  static Future<void> _removeCurrentToast({bool immediate = false}) async {
    _dismissTimer?.cancel();
    _dismissTimer = null;

    final entry = _currentEntry;
    final controller = _currentController;

    _currentEntry = null;
    _currentController = null;

    if (entry == null) {
      controller?.dispose();
      return;
    }

    if (!immediate && controller != null) {
      try {
        await controller.reverse();
      } catch (_) {}
    }

    entry.remove();
    controller?.dispose();
  }
}

class _AppToastOverlay extends StatelessWidget {
  const _AppToastOverlay({
    required this.animation,
    required this.message,
    required this.borderColor,
  });

  final Animation<double> animation;
  final String message;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return IgnorePointer(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
          child: Align(
            alignment: Alignment.topRight,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(1.1, 0),
                end: Offset.zero,
              ).animate(animation),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 360),
                child: Material(
                  color: Colors.transparent,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: AppTheme.darkSurface,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: borderColor),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.28),
                          blurRadius: 18,
                          offset: const Offset(0, 10),
                        ),
                        BoxShadow(
                          color: borderColor.withValues(alpha: 0.12),
                          blurRadius: 20,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: borderColor,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Flexible(
                          child: Text(
                            message,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: textTheme.bodyLarge?.copyWith(
                              color: AppTheme.baseWhite,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
