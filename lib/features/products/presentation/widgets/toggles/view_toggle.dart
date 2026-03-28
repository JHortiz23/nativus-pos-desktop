import 'package:flutter/material.dart';
import 'package:nativus_pos_desktop/application/theme/theme.dart';
import 'package:nativus_pos_desktop/features/products/presentation/widgets/cards/product_card.dart';

class ProductViewToggle extends StatelessWidget {
  const ProductViewToggle({
    super.key,
    required this.layout,
    required this.onChanged,
  });

  final ProductCardLayout layout;
  final ValueChanged<ProductCardLayout> onChanged;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: colorScheme.darkSurfaceAlt,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: colorScheme.softBorder),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _ViewToggleButton(
            icon: Icons.grid_view_rounded,
            selected: layout == ProductCardLayout.grid,
            onTap: () => onChanged(ProductCardLayout.grid),
          ),
          const SizedBox(width: 6),
          _ViewToggleButton(
            icon: Icons.view_agenda_outlined,
            selected: layout == ProductCardLayout.list,
            onTap: () => onChanged(ProductCardLayout.list),
          ),
        ],
      ),
    );
  }
}

class _ViewToggleButton extends StatelessWidget {
  const _ViewToggleButton({
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Material(
      color: selected
          ? colorScheme.accentPrimary.withValues(alpha: 0.2)
          : Colors.transparent,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: SizedBox(
          width: 34,
          height: 34,
          child: Icon(
            icon,
            color: selected ? colorScheme.baseWhite : colorScheme.textMuted,
            size: 20,
          ),
        ),
      ),
    );
  }
}
