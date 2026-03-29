import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:nativus_pos_desktop/application/theme/theme.dart';
import 'package:nativus_pos_desktop/features/products/domain/entities/products_entity.dart';
import 'package:nativus_pos_desktop/features/products/presentation/blocs/products_bloc.dart';
import 'package:nativus_pos_desktop/features/products/presentation/models/product_category.dart';
import 'package:nativus_pos_desktop/features/products/presentation/widgets/cards/product_card.dart';
import 'package:nativus_pos_desktop/features/products/presentation/widgets/cards/products_grid.dart';
import 'package:nativus_pos_desktop/features/products/presentation/widgets/cards/products_list.dart';
import 'package:nativus_pos_desktop/features/products/presentation/widgets/empty_products_state.dart';
import 'package:nativus_pos_desktop/features/products/presentation/widgets/filters/category_chip.dart';
import 'package:nativus_pos_desktop/features/products/presentation/widgets/filters/search_field.dart';
import 'package:nativus_pos_desktop/features/products/presentation/widgets/toggles/view_toggle.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  static const String _allCategoryId = 'all';

  late final NumberFormat _currencyFormat;
  late final ScrollController _scrollController;
  ProductCardLayout _layout = ProductCardLayout.grid;

  final List<ProductCategory> _categories = const [
    ProductCategory(
      id: _allCategoryId,
      label: 'Todo',
      icon: Icons.dashboard_customize_rounded,
    ),
    ProductCategory(
      id: 'bebidas',
      label: 'Bebidas',
      icon: Icons.local_bar_rounded,
    ),
    ProductCategory(
      id: 'mariscos',
      label: 'Mariscos',
      icon: Icons.set_meal_rounded,
    ),
    ProductCategory(
      id: 'comida-rapida',
      label: 'Comida Rapida',
      icon: Icons.lunch_dining_rounded,
    ),
    ProductCategory(id: 'postres', label: 'Postres', icon: Icons.cake_outlined),
    ProductCategory(
      id: 'entradas',
      label: 'Entradas',
      icon: Icons.ramen_dining_rounded,
    ),
    ProductCategory(
      id: 'carnes',
      label: 'Carnes',
      icon: Icons.kebab_dining_rounded,
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

    return BlocBuilder<ProductsBloc, ProductsState>(
      builder: (context, state) {
        final visibleProducts = state.products?.items ?? const <ProductsEntity>[];

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
                    final searchField = const ProductSearchField(
                      enabled: false,
                      onChanged: _noopOnSearchChanged,
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
                              ProductViewToggle(
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
                                  ProductViewToggle(
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
                                  ProductCategoryChip(
                                    label: category.label,
                                    icon: category.icon,
                                    selected: category.id == _allCategoryId,
                                    enabled: false,
                                    onTap: () {},
                                  ),
                              ],
                            ),
                            const SizedBox(height: 22),
                            if (state.isLoading && visibleProducts.isEmpty)
                              const Center(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 48),
                                  child: CircularProgressIndicator(),
                                ),
                              )
                            else if (state.errorMessage.isNotEmpty &&
                                visibleProducts.isEmpty)
                              _ProductsErrorState(
                                message: state.errorMessage,
                                onRetry: () {
                                  context.read<ProductsBloc>().add(
                                    const GetProductsEvent(),
                                  );
                                },
                              )
                            else
                              AnimatedSwitcher(
                                duration: const Duration(milliseconds: 180),
                                child: visibleProducts.isEmpty
                                    ? const EmptyProductsState(
                                        key: ValueKey('empty-products-state'),
                                        query: '',
                                      )
                                    : _layout == ProductCardLayout.grid
                                    ? ProductsGrid(
                                        key: const ValueKey('products-grid'),
                                        children: _buildProductCards(
                                          visibleProducts,
                                          ProductCardLayout.grid,
                                        ),
                                      )
                                    : ProductsList(
                                        key: const ValueKey('products-list'),
                                        children: _buildProductCards(
                                          visibleProducts,
                                          ProductCardLayout.list,
                                        ),
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
      },
    );
  }

  String _formatPrice(num value) {
    return 'CRC ${_currencyFormat.format(value).replaceAll('.', ' ')}';
  }

  List<Widget> _buildProductCards(
    List<ProductsEntity> products,
    ProductCardLayout layout,
  ) {
    return [
      for (final product in products)
        ProductCard(
          layout: layout,
          name: product.name,
          description: product.description,
          price: _formatPrice(product.price),
          category: 'General',
          productIcon: _resolveProductIcon(product),
          isActive: product.isActive,
        ),
    ];
  }

  static void _noopOnSearchChanged(String _) {}

  IconData _resolveProductIcon(ProductsEntity product) {
    final normalizedName = product.name.toLowerCase();

    if (normalizedName.contains('cafe') || normalizedName.contains('coffee')) {
      return Icons.local_cafe_rounded;
    }
    if (normalizedName.contains('agua') ||
        normalizedName.contains('jugo') ||
        normalizedName.contains('refresco') ||
        normalizedName.contains('bebida')) {
      return Icons.local_drink_rounded;
    }
    if (normalizedName.contains('postre') || normalizedName.contains('cake')) {
      return Icons.cake_rounded;
    }
    if (normalizedName.contains('pizza') ||
        normalizedName.contains('hamburguesa') ||
        normalizedName.contains('burger')) {
      return Icons.lunch_dining_rounded;
    }

    return Icons.inventory_2_rounded;
  }
}

class _ProductsErrorState extends StatelessWidget {
  const _ProductsErrorState({required this.message, required this.onRetry});

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
