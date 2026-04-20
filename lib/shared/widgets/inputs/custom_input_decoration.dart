import 'package:flutter/material.dart';
import 'package:nativus_pos_desktop/application/theme/theme.dart';

class CustomInputDecoration {
  static InputDecoration decor(BuildContext context, String hint) {
    final cs = Theme.of(context).colorScheme;
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: cs.softBorder),
    );
    final errorBorder = border.copyWith(
      borderSide: BorderSide(color: cs.error),
    );
    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(color: cs.textMuted.withValues(alpha: 0.5)),
      filled: true,
      fillColor: cs.darkSurfaceAlt,
      contentPadding: const EdgeInsets.all(16),
      border: border,
      enabledBorder: border,
      focusedBorder: border.copyWith(
        borderSide: BorderSide(color: cs.accentPrimary),
      ),
      errorBorder: errorBorder,
      focusedErrorBorder: errorBorder,
      errorStyle: const TextStyle(
        height: 0,
        fontSize: 0,
        color: Colors.transparent,
      ),
    );
  }
}
