import 'package:flutter/material.dart';
import 'package:nativus_pos_desktop/application/theme/theme.dart';

class ProductSearchField extends StatelessWidget {
  const ProductSearchField({super.key, required this.onChanged});

  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = Theme.of(context).colorScheme;

    return TextField(
      onChanged: onChanged,
      cursorColor: colorScheme.accentPrimary,
      style: theme.textTheme.bodyLarge?.copyWith(
        color: colorScheme.baseWhite,
        fontSize: 16,
      ),
      decoration: InputDecoration(
        hintText: 'Buscar producto...',
        hintStyle: theme.textTheme.bodyMedium?.copyWith(
          color: colorScheme.textMuted,
          fontSize: 15,
        ),
        filled: true,
        fillColor: colorScheme.darkSurfaceAlt,
        prefixIcon: Icon(Icons.search_rounded, color: colorScheme.textMuted),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide(color: colorScheme.softBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide(color: colorScheme.accentPrimary),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide(color: colorScheme.softBorder),
        ),
      ),
    );
  }
}
