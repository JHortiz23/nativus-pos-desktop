import 'package:flutter/material.dart';
import 'package:nativus_pos_desktop/application/theme/theme.dart';
import 'package:nativus_pos_desktop/core/enums/view_enum.dart';
import 'package:nativus_pos_desktop/features/products/presentation/widgets/buttons/action_button.dart';
import 'package:nativus_pos_desktop/features/products/presentation/widgets/badages/category_badge.dart';
import 'package:nativus_pos_desktop/features/products/presentation/widgets/cards/product_leading.dart';
import 'package:nativus_pos_desktop/features/products/presentation/widgets/badages/status_badge.dart';
import 'package:nativus_pos_desktop/features/products/presentation/widgets/cards/tooltip_text.dart';
import 'package:nativus_pos_desktop/l10n/app_localizations.dart';

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
    final localizations = AppLocalizations.of(context)!;
    final displayDescription = description.trim().isEmpty
        ? localizations.no_description
        : description;

    return switch (layout) {
      ProductCardLayout.grid => _GridProductCard(
        name: name,
        description: displayDescription,
        price: price,
        category: category,
        productIcon: productIcon,
        isActive: isActive,
      ),
      ProductCardLayout.list => _ListProductCard(
        name: name,
        description: displayDescription,
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
    final localizations = AppLocalizations.of(context)!;

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
                  TooltipText(
                    message: name,
                    maxLines: 2,
                    style: theme.textTheme.headlineSmall?.copyWith(
                      color: colorScheme.baseWhite,
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 6),
                  TooltipText(
                    message: description,
                    maxLines: 1,
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
                      const SizedBox(width: 12),
                      Flexible(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: CategoryBadge(label: category),
                        ),
                      ),
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
                  localizations.product_card_inactive_caps,
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
                      ProductLeading(
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
                          StatusBadge(isActive: isActive),
                          ActionButton(
                            icon: Icons.edit_outlined,
                            color: colorScheme.textSoft,
                            background: colorScheme.darkSurfaceAlt,
                          ),
                          ActionButton(
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
                        child: ProductLeading(
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
                      StatusBadge(isActive: isActive),
                      const SizedBox(width: 10),
                      ActionButton(
                        icon: Icons.edit_outlined,
                        color: colorScheme.textSoft,
                        background: colorScheme.darkSurfaceAlt,
                      ),
                      const SizedBox(width: 10),
                      ActionButton(
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
