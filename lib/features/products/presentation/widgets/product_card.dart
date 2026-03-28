import 'package:flutter/material.dart';
import 'package:nativus_pos_desktop/application/theme/theme.dart';

enum ProductCardLayout { grid, list }

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.layout,
    required this.name,
    required this.description,
    required this.price,
    required this.category,
    required this.productIcon,
    required this.isActive,
  });

  final ProductCardLayout layout;
  final String name;
  final String description;
  final String price;
  final String category;
  final IconData productIcon;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return switch (layout) {
      ProductCardLayout.grid => _GridProductCard(
        name: name,
        description: description,
        price: price,
        category: category,
        productIcon: productIcon,
        isActive: isActive,
      ),
      ProductCardLayout.list => _ListProductCard(
        name: name,
        description: description,
        price: price,
        category: category,
        productIcon: productIcon,
        isActive: isActive,
      ),
    };
  }
}

class _GridProductCard extends StatelessWidget {
  const _GridProductCard({
    required this.name,
    required this.description,
    required this.price,
    required this.category,
    required this.productIcon,
    required this.isActive,
  });

  final String name;
  final String description;
  final String price;
  final String category;
  final IconData productIcon;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.darkSurface,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: colorScheme.softBorder),
      ),
      child: Stack(
        children: [
          Opacity(
            opacity: isActive ? 1 : 0.48,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      color: colorScheme.accentPrimary.withValues(alpha: 0.14),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Icon(
                      productIcon,
                      color: colorScheme.accentPrimary,
                      size: 30,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.headlineSmall?.copyWith(
                      color: colorScheme.baseWhite,
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: colorScheme.textMuted,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 18),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          price,
                          style: theme.textTheme.headlineSmall?.copyWith(
                            color: colorScheme.accentPrimary,
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      _CategoryBadge(label: category),
                    ],
                  ),
                ],
              ),
            ),
          ),
          if (!isActive)
            Positioned(
              top: 16,
              right: 16,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 7,
                ),
                decoration: BoxDecoration(
                  color: colorScheme.darkSurfaceAlt.withValues(alpha: 0.92),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: colorScheme.softBorder),
                ),
                child: Text(
                  'INACTIVO',
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: colorScheme.textMuted,
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _ListProductCard extends StatelessWidget {
  const _ListProductCard({
    required this.name,
    required this.description,
    required this.price,
    required this.category,
    required this.productIcon,
    required this.isActive,
  });

  final String name;
  final String description;
  final String price;
  final String category;
  final IconData productIcon;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = Theme.of(context).colorScheme;

    return LayoutBuilder(
      builder: (context, constraints) {
        final isCompact = constraints.maxWidth < 760;

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
          decoration: BoxDecoration(
            color: colorScheme.darkSurface,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: colorScheme.softBorder),
          ),
          child: Opacity(
            opacity: isActive ? 1 : 0.48,
            child: isCompact
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _ProductLeading(
                        name: name,
                        description: description,
                        category: category,
                        productIcon: productIcon,
                      ),
                      const SizedBox(height: 16),
                      Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Text(
                            price,
                            style: theme.textTheme.headlineSmall?.copyWith(
                              color: colorScheme.accentPrimary,
                              fontSize: 17,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          _StatusBadge(isActive: isActive),
                          _ActionButton(
                            icon: Icons.edit_outlined,
                            color: colorScheme.textSoft,
                            background: colorScheme.darkSurfaceAlt,
                          ),
                          _ActionButton(
                            icon: Icons.delete_outline_rounded,
                            color: colorScheme.redOrange,
                            background: colorScheme.redOrange.withValues(
                              alpha: 0.12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                : Row(
                    children: [
                      Expanded(
                        child: _ProductLeading(
                          name: name,
                          description: description,
                          category: category,
                          productIcon: productIcon,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Text(
                        price,
                        style: theme.textTheme.headlineSmall?.copyWith(
                          color: colorScheme.accentPrimary,
                          fontSize: 17,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(width: 16),
                      _StatusBadge(isActive: isActive),
                      const SizedBox(width: 10),
                      _ActionButton(
                        icon: Icons.edit_outlined,
                        color: colorScheme.textSoft,
                        background: colorScheme.darkSurfaceAlt,
                      ),
                      const SizedBox(width: 10),
                      _ActionButton(
                        icon: Icons.delete_outline_rounded,
                        color: colorScheme.redOrange,
                        background: colorScheme.redOrange.withValues(
                          alpha: 0.12,
                        ),
                      ),
                    ],
                  ),
          ),
        );
      },
    );
  }
}

class _ProductLeading extends StatelessWidget {
  const _ProductLeading({
    required this.name,
    required this.description,
    required this.category,
    required this.productIcon,
  });

  final String name;
  final String description;
  final String category;
  final IconData productIcon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: colorScheme.accentPrimary.withValues(alpha: 0.14),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Icon(productIcon, color: colorScheme.accentPrimary, size: 26),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.headlineSmall?.copyWith(
                  color: colorScheme.baseWhite,
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '$description - $category',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: colorScheme.textMuted,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _CategoryBadge extends StatelessWidget {
  const _CategoryBadge({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
        color: colorScheme.darkSurfaceAlt,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: theme.textTheme.bodyLarge?.copyWith(
          color: colorScheme.textMuted,
          fontSize: 12,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  const _StatusBadge({required this.isActive});

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    final foreground = isActive ? colorScheme.baseGreen : colorScheme.textMuted;
    final background = isActive
        ? colorScheme.baseGreen.withValues(alpha: 0.12)
        : colorScheme.darkSurfaceAlt;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: colorScheme.softBorder),
      ),
      child: Text(
        isActive ? 'Activo' : 'Inactivo',
        style: theme.textTheme.bodyLarge?.copyWith(
          color: foreground,
          fontSize: 13,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.icon,
    required this.color,
    required this.background,
  });

  final IconData icon;
  final Color color;
  final Color background;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: 42,
      height: 42,
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: colorScheme.softBorder),
      ),
      child: Icon(icon, color: color, size: 20),
    );
  }
}
