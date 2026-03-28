import 'package:flutter/material.dart';
import 'package:nativus_pos_desktop/application/theme/theme.dart';

class EmptyProductsState extends StatelessWidget {
  const EmptyProductsState({super.key, required this.query});

  final String query;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
      decoration: BoxDecoration(
        color: colorScheme.darkSurfaceAlt,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: colorScheme.softBorder),
      ),
      child: Column(
        children: [
          Icon(
            Icons.search_off_rounded,
            size: 42,
            color: colorScheme.accentPrimary,
          ),
          const SizedBox(height: 16),
          Text(
            'No hay productos para mostrar',
            style: theme.textTheme.headlineSmall?.copyWith(
              color: colorScheme.baseWhite,
              fontSize: 22,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            query.isEmpty
                ? 'Prueba con otra categoria para ver los elementos mock disponibles.'
                : 'No encontramos coincidencias para tu busqueda actual.',
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: colorScheme.textMuted,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }
}
