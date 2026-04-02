import 'package:flutter/material.dart';
import 'package:nativus_pos_desktop/application/theme/theme.dart';

class ProductsErrorState extends StatelessWidget {
  const ProductsErrorState({
    super.key,
    required this.message,
    required this.onRetry,
  });

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      decoration: BoxDecoration(
        color: colorScheme.darkSurfaceAlt,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: colorScheme.softBorder),
      ),
      child: Column(
        children: [
          Icon(
            Icons.error_outline_rounded,
            size: 42,
            color: colorScheme.redOrange,
          ),
          const SizedBox(height: 16),
          Text(
            'No fue posible cargar los productos',
            style: theme.textTheme.headlineSmall?.copyWith(
              color: colorScheme.baseWhite,
              fontSize: 22,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            message,
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: colorScheme.textMuted,
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 20),
          FilledButton(onPressed: onRetry, child: const Text('Reintentar')),
        ],
      ),
    );
  }
}
