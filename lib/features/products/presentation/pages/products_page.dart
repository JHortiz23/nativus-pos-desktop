import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nativus_pos_desktop/application/theme/theme.dart';
import 'package:nativus_pos_desktop/features/products/presentation/widgets/product_card.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  static const String _allCategoryId = 'all';

  late final NumberFormat _currencyFormat;
  late final ScrollController _scrollController;
  String _selectedCategoryId = _allCategoryId;
  String _searchQuery = '';
  ProductCardLayout _layout = ProductCardLayout.grid;

  final List<_ProductCategory> _categories = const [
    _ProductCategory(
      id: _allCategoryId,
      label: 'Todo',
      icon: Icons.dashboard_customize_rounded,
    ),
    _ProductCategory(
      id: 'bebidas',
      label: 'Bebidas',
      icon: Icons.local_bar_rounded,
    ),
    _ProductCategory(
      id: 'mariscos',
      label: 'Mariscos',
      icon: Icons.set_meal_rounded,
    ),
    _ProductCategory(
      id: 'comida-rapida',
      label: 'Comida Rapida',
      icon: Icons.lunch_dining_rounded,
    ),
    _ProductCategory(
      id: 'postres',
      label: 'Postres',
      icon: Icons.cake_outlined,
    ),
    _ProductCategory(
      id: 'entradas',
      label: 'Entradas',
      icon: Icons.ramen_dining_rounded,
    ),
    _ProductCategory(
      id: 'carnes',
      label: 'Carnes',
      icon: Icons.kebab_dining_rounded,
    ),
  ];

  final List<_MockProduct> _products = const [
    _MockProduct(
      name: 'Agua Mineral',
      description: '500 ml',
      price: 1800,
      categoryId: 'bebidas',
      categoryLabel: 'Bebidas',
      icon: Icons.water_drop_rounded,
      isActive: true,
    ),
    _MockProduct(
      name: 'Coca-Cola',
      description: '350 ml',
      price: 2200,
      categoryId: 'bebidas',
      categoryLabel: 'Bebidas',
      icon: Icons.local_cafe_outlined,
      isActive: false,
    ),
    _MockProduct(
      name: 'Jugo Natural',
      description: 'Vaso 16 oz',
      price: 3500,
      categoryId: 'bebidas',
      categoryLabel: 'Bebidas',
      icon: Icons.emoji_food_beverage_rounded,
      isActive: false,
    ),
    _MockProduct(
      name: 'Cerveza Nacional',
      description: '330 ml',
      price: 4500,
      categoryId: 'bebidas',
      categoryLabel: 'Bebidas',
      icon: Icons.sports_bar_rounded,
      isActive: true,
    ),
    _MockProduct(
      name: 'Limonada Natural',
      description: 'Con o sin azucar',
      price: 3000,
      categoryId: 'bebidas',
      categoryLabel: 'Bebidas',
      icon: Icons.emoji_food_beverage_outlined,
      isActive: true,
    ),
    _MockProduct(
      name: 'Ceviche Camaron',
      description: 'Porcion completa',
      price: 12500,
      categoryId: 'mariscos',
      categoryLabel: 'Mariscos',
      icon: Icons.set_meal_rounded,
      isActive: true,
    ),
    _MockProduct(
      name: 'Corvina al Vapor',
      description: 'Con vegetales',
      price: 18000,
      categoryId: 'mariscos',
      categoryLabel: 'Mariscos',
      icon: Icons.phishing_rounded,
      isActive: true,
    ),
    _MockProduct(
      name: 'Pulpo a la Brasa',
      description: 'Con papas',
      price: 22000,
      categoryId: 'mariscos',
      categoryLabel: 'Mariscos',
      icon: Icons.restaurant_menu_rounded,
      isActive: true,
    ),
    _MockProduct(
      name: 'Hamburguesa Clasica',
      description: 'Con papas fritas',
      price: 9500,
      categoryId: 'comida-rapida',
      categoryLabel: 'Comida Rapida',
      icon: Icons.lunch_dining_rounded,
      isActive: true,
    ),
    _MockProduct(
      name: 'Hot Dog Especial',
      description: 'Mostaza y ketchup',
      price: 6500,
      categoryId: 'comida-rapida',
      categoryLabel: 'Comida Rapida',
      icon: Icons.lunch_dining_outlined,
      isActive: true,
    ),
    _MockProduct(
      name: 'Casado de Pollo',
      description: 'Arroz y frijoles',
      price: 10500,
      categoryId: 'entradas',
      categoryLabel: 'Entradas',
      icon: Icons.rice_bowl_rounded,
      isActive: true,
    ),
    _MockProduct(
      name: 'Tiramisu',
      description: 'Porcion individual',
      price: 5500,
      categoryId: 'postres',
      categoryLabel: 'Postres',
      icon: Icons.cake_rounded,
      isActive: true,
    ),
    _MockProduct(
      name: 'Ribeye a la Parrilla',
      description: '300 g con mantequilla',
      price: 26500,
      categoryId: 'carnes',
      categoryLabel: 'Carnes',
      icon: Icons.outdoor_grill_rounded,
      isActive: true,
    ),
    _MockProduct(
      name: 'Costilla BBQ',
      description: 'Glaseado de la casa',
      price: 19800,
      categoryId: 'carnes',
      categoryLabel: 'Carnes',
      icon: Icons.local_dining_rounded,
      isActive: false,
    ),
    _MockProduct(
      name: 'Crema de Ayote',
      description: 'Entrada caliente',
      price: 4200,
      categoryId: 'entradas',
      categoryLabel: 'Entradas',
      icon: Icons.soup_kitchen_rounded,
      isActive: true,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _currencyFormat = NumberFormat.decimalPattern('es_CR');
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    final visibleProducts = _filteredProducts;

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.darkSurface,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: colorScheme.softBorder),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 22, 12, 18),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final isCompactHeader = constraints.maxWidth < 760;
                final titleBlock = Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Gestion de Productos',
                      style: theme.textTheme.headlineMedium?.copyWith(
                        color: colorScheme.baseWhite,
                        fontSize: 34,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Administra tu catalogo, categorias y estado visual de cada producto.',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: colorScheme.textMuted,
                        fontSize: 15,
                      ),
                    ),
                  ],
                );
                final actionBlock = Flex(
                  direction: isCompactHeader ? Axis.vertical : Axis.horizontal,
                  crossAxisAlignment: isCompactHeader
                      ? CrossAxisAlignment.start
                      : CrossAxisAlignment.center,
                  children: [
                    Text(
                      '${visibleProducts.length} productos',
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: colorScheme.textSoft,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      width: isCompactHeader ? 0 : 18,
                      height: isCompactHeader ? 14 : 0,
                    ),
                    IgnorePointer(
                      ignoring: true,
                      child: FilledButton.icon(
                        onPressed: () {},
                        style: FilledButton.styleFrom(
                          backgroundColor: colorScheme.accentPrimary,
                          foregroundColor: colorScheme.black,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 22,
                            vertical: 18,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          textStyle: theme.textTheme.bodyLarge?.copyWith(
                            fontSize: 15,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        icon: const Icon(Icons.add_rounded),
                        label: const Text('Nuevo Producto'),
                      ),
                    ),
                  ],
                );

                if (isCompactHeader) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      titleBlock,
                      const SizedBox(height: 18),
                      actionBlock,
                    ],
                  );
                }

                return Row(
                  children: [
                    Expanded(child: titleBlock),
                    const SizedBox(width: 18),
                    actionBlock,
                  ],
                );
              },
            ),
          ),
          Divider(
            height: 1,
            color: colorScheme.softBorder.withValues(alpha: 0.7),
          ),
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final isCompactControls = constraints.maxWidth < 880;
                final searchField = _SearchField(
                  onChanged: (value) {
                    setState(() {
                      _searchQuery = value.trim().toLowerCase();
                    });
                  },
                );

                return Scrollbar(
                  controller: _scrollController,
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    padding: const EdgeInsets.fromLTRB(8, 24, 8, 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (isCompactControls) ...[
                          searchField,
                          const SizedBox(height: 14),
                          _ViewToggle(
                            layout: _layout,
                            onChanged: (layout) {
                              setState(() {
                                _layout = layout;
                              });
                            },
                          ),
                        ] else
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(child: searchField),
                              const SizedBox(width: 14),
                              _ViewToggle(
                                layout: _layout,
                                onChanged: (layout) {
                                  setState(() {
                                    _layout = layout;
                                  });
                                },
                              ),
                            ],
                          ),
                        const SizedBox(height: 20),
                        Wrap(
                          spacing: 12,
                          runSpacing: 12,
                          children: [
                            for (final category in _categories)
                              _CategoryChip(
                                category: category,
                                selected: category.id == _selectedCategoryId,
                                onTap: () {
                                  setState(() {
                                    _selectedCategoryId = category.id;
                                  });
                                },
                              ),
                          ],
                        ),
                        const SizedBox(height: 22),
                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 180),
                          child: visibleProducts.isEmpty
                              ? _EmptyProductsState(
                                  key: const ValueKey('empty-products-state'),
                                  query: _searchQuery,
                                )
                              : _layout == ProductCardLayout.grid
                              ? _ProductsGrid(
                                  key: const ValueKey('products-grid'),
                                  products: visibleProducts,
                                  formatPrice: _formatPrice,
                                )
                              : _ProductsList(
                                  key: const ValueKey('products-list'),
                                  products: visibleProducts,
                                  formatPrice: _formatPrice,
                                ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  List<_MockProduct> get _filteredProducts {
    return _products.where((product) {
      final matchesCategory =
          _selectedCategoryId == _allCategoryId ||
          product.categoryId == _selectedCategoryId;
      final matchesSearch =
          _searchQuery.isEmpty ||
          product.name.toLowerCase().contains(_searchQuery) ||
          product.description.toLowerCase().contains(_searchQuery) ||
          product.categoryLabel.toLowerCase().contains(_searchQuery);

      return matchesCategory && matchesSearch;
    }).toList();
  }

  String _formatPrice(int value) {
    return 'CRC ${_currencyFormat.format(value).replaceAll('.', ' ')}';
  }
}

class _ProductsGrid extends StatelessWidget {
  const _ProductsGrid({
    super.key,
    required this.products,
    required this.formatPrice,
  });

  final List<_MockProduct> products;
  final String Function(int value) formatPrice;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final crossAxisCount = switch (width) {
          < 760 => 1,
          < 1080 => 2,
          < 1380 => 3,
          _ => 4,
        };

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: products.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            mainAxisExtent: 224,
          ),
          itemBuilder: (context, index) {
            final product = products[index];

            return ProductCard(
              layout: ProductCardLayout.grid,
              name: product.name,
              description: product.description,
              price: formatPrice(product.price),
              category: product.categoryLabel,
              productIcon: product.icon,
              isActive: product.isActive,
            );
          },
        );
      },
    );
  }
}

class _ProductsList extends StatelessWidget {
  const _ProductsList({
    super.key,
    required this.products,
    required this.formatPrice,
  });

  final List<_MockProduct> products;
  final String Function(int value) formatPrice;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var index = 0; index < products.length; index++) ...[
          ProductCard(
            layout: ProductCardLayout.list,
            name: products[index].name,
            description: products[index].description,
            price: formatPrice(products[index].price),
            category: products[index].categoryLabel,
            productIcon: products[index].icon,
            isActive: products[index].isActive,
          ),
          if (index != products.length - 1) const SizedBox(height: 12),
        ],
      ],
    );
  }
}

class _SearchField extends StatelessWidget {
  const _SearchField({required this.onChanged});

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

class _CategoryChip extends StatelessWidget {
  const _CategoryChip({
    required this.category,
    required this.selected,
    required this.onTap,
  });

  final _ProductCategory category;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    final background = selected
        ? colorScheme.accentPrimary.withValues(alpha: 0.18)
        : colorScheme.darkSurfaceAlt;
    final foreground = selected
        ? colorScheme.accentPrimary
        : colorScheme.textSoft;

    return Material(
      color: background,
      borderRadius: BorderRadius.circular(999),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(999),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(category.icon, size: 16, color: foreground),
              const SizedBox(width: 8),
              Text(
                category.label,
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: foreground,
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

class _ViewToggle extends StatelessWidget {
  const _ViewToggle({required this.layout, required this.onChanged});

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
          width: 48,
          height: 48,
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

class _EmptyProductsState extends StatelessWidget {
  const _EmptyProductsState({super.key, required this.query});

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

class _ProductCategory {
  const _ProductCategory({
    required this.id,
    required this.label,
    required this.icon,
  });

  final String id;
  final String label;
  final IconData icon;
}

class _MockProduct {
  const _MockProduct({
    required this.name,
    required this.description,
    required this.price,
    required this.categoryId,
    required this.categoryLabel,
    required this.icon,
    required this.isActive,
  });

  final String name;
  final String description;
  final int price;
  final String categoryId;
  final String categoryLabel;
  final IconData icon;
  final bool isActive;
}
