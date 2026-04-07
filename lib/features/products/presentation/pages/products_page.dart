import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:nativus_pos_desktop/application/theme/theme.dart';
import 'package:nativus_pos_desktop/core/enums/view_enum.dart';
import 'package:nativus_pos_desktop/features/products/domain/entities/product_categories_entity.dart';
import 'package:nativus_pos_desktop/features/products/domain/entities/products_entity.dart';
import 'package:nativus_pos_desktop/features/products/presentation/blocs/products_bloc.dart';
import 'package:nativus_pos_desktop/features/products/presentation/helpers/product_category_filter_helper.dart';
import 'package:nativus_pos_desktop/features/products/presentation/helpers/product_category_icon_helper.dart';
import 'package:nativus_pos_desktop/features/products/presentation/widgets/cards/product_card.dart';
import 'package:nativus_pos_desktop/features/products/presentation/widgets/cards/products_grid.dart';
import 'package:nativus_pos_desktop/features/products/presentation/widgets/cards/products_list.dart';
import 'package:nativus_pos_desktop/features/products/presentation/widgets/dialogs/add_product_dialog.dart';
import 'package:nativus_pos_desktop/features/products/presentation/widgets/empty_products_state.dart';
import 'package:nativus_pos_desktop/features/products/presentation/widgets/filters/category_chip.dart';
import 'package:nativus_pos_desktop/features/products/presentation/widgets/products_error_state.dart';
import 'package:nativus_pos_desktop/features/products/presentation/widgets/filters/search_field.dart';
import 'package:nativus_pos_desktop/features/products/presentation/widgets/toggles/view_toggle.dart';
import 'package:nativus_pos_desktop/l10n/app_localizations.dart';
import 'package:nativus_pos_desktop/shared/shared.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  late final NumberFormat _currencyFormat;
  late final ScrollController _scrollController;
  late final TextEditingController _searchController;
  // Products Bloc
  late final ProductsBloc _productsBloc;
  ProductCardLayout _layout = ProductCardLayout.grid;
  int? _selectedCategoryId;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _currencyFormat = NumberFormat.decimalPattern('es_CR');
    _scrollController = ScrollController();
    _searchController = TextEditingController();
    _productsBloc = context.read<ProductsBloc>();
    // Load initial products
    _productsBloc.add(const GetProductsEvent());
    // Load product categories
    _productsBloc.add(const GetProductCategoriesEvent());
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    final localizations = AppLocalizations.of(context)!;

    return BlocListener<ProductsBloc, ProductsState>(
      listenWhen: (previous, current) =>
          current is ProductDeleted ||
          (previous is DeletingProduct && current is ProductError),
      listener: (context, state) {
        if (state is ProductDeleted) {
          AppToast.show(
            context,
            message: localizations.message_product_deleted,
            borderColor: colorScheme.baseGreen,
          );
        } else if (state is ProductError) {
          AppToast.show(
            context,
            message: state.errorMessage,
            borderColor: colorScheme.error,
          );
        }
      },
      child: BlocBuilder<ProductsBloc, ProductsState>(
        builder: (context, state) {
          final allProducts = state.products?.items ?? const <ProductsEntity>[];
          final categories =
              state.productCategories ?? const <ProductCategoriesEntity>[];
          final registeredCategories =
              ProductCategoryFilterHelper.registeredCategories(
                categories: categories,
                products: allProducts,
              );
          final availableCategoryIds = registeredCategories
              .map((category) => category.id)
              .toSet();
          final selectedCategoryId =
              availableCategoryIds.contains(_selectedCategoryId)
              ? _selectedCategoryId
              : null;
          final visibleProducts = _applyFilters(
            products: allProducts,
            selectedCategoryId: selectedCategoryId,
          );

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
                            localizations.product_management,
                            style: theme.textTheme.headlineMedium?.copyWith(
                              color: colorScheme.baseWhite,
                              fontSize: 34,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            localizations.product_management_description,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: colorScheme.textMuted,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      );
                      final actionBlock = Flex(
                        direction: isCompactHeader
                            ? Axis.vertical
                            : Axis.horizontal,
                        crossAxisAlignment: isCompactHeader
                            ? CrossAxisAlignment.start
                            : CrossAxisAlignment.center,
                        children: [
                          Text(
                            visibleProducts.length == 1
                                ? '${visibleProducts.length} ${localizations.product_label}'
                                : '${visibleProducts.length} ${localizations.sidebarProducts}',
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
                          FilledButton.icon(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => const AddProductDialog(),
                              );
                            },
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
                            label: Text(localizations.new_product),
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
                      final interactiveSearchField = ProductSearchField(
                        controller: _searchController,
                        onChanged: (value) {
                          setState(() {
                            _searchQuery = value;
                          });
                        },
                      );
                      final categoryChips = <Widget>[
                        ProductCategoryChip(
                          label: localizations.all_label,
                          icon: Icons.apps_rounded,
                          selected: selectedCategoryId == null,
                          onTap: () {
                            setState(() {
                              _selectedCategoryId = null;
                            });
                          },
                        ),
                        for (final category in registeredCategories)
                          ProductCategoryChip(
                            label: category.name,
                            icon: ProductCategoryIconHelper.resolve(
                              category.name,
                            ),
                            selected: selectedCategoryId == category.id,
                            onTap: () {
                              setState(() {
                                _selectedCategoryId = category.id;
                              });
                            },
                          ),
                      ];

                      return Padding(
                        padding: const EdgeInsets.fromLTRB(8, 24, 8, 24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (isCompactControls) ...[
                              interactiveSearchField,
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
                                  Expanded(child: interactiveSearchField),
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
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  for (
                                    var index = 0;
                                    index < categoryChips.length;
                                    index++
                                  ) ...[
                                    categoryChips[index],
                                    if (index != categoryChips.length - 1)
                                      const SizedBox(width: 12),
                                  ],
                                ],
                              ),
                            ),
                            const SizedBox(height: 22),
                            Expanded(
                              child: Builder(
                                builder: (context) {
                                  if (state.isLoading &&
                                      visibleProducts.isEmpty) {
                                    return const Center(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                          vertical: 48,
                                        ),
                                        child: CircularProgressIndicator(),
                                      ),
                                    );
                                  }

                                  if (state.errorMessage.isNotEmpty &&
                                      visibleProducts.isEmpty) {
                                    return ProductsErrorState(
                                      message: state.errorMessage,
                                      onRetry: () {
                                        context.read<ProductsBloc>().add(
                                          const GetProductsEvent(),
                                        );
                                      },
                                    );
                                  }

                                  if (visibleProducts.isEmpty) {
                                    return EmptyProductsState(
                                      key: const ValueKey(
                                        'empty-products-state',
                                      ),
                                      query: _searchQuery.trim(),
                                    );
                                  }

                                  return Scrollbar(
                                    controller: _scrollController,
                                    child: SingleChildScrollView(
                                      controller: _scrollController,
                                      child: AnimatedSwitcher(
                                        duration: const Duration(
                                          milliseconds: 180,
                                        ),
                                        child: _layout == ProductCardLayout.grid
                                            ? ProductsGrid(
                                                key: const ValueKey(
                                                  'products-grid',
                                                ),
                                                children: _buildProductCards(
                                                  visibleProducts,
                                                  ProductCardLayout.grid,
                                                ),
                                              )
                                            : ProductsList(
                                                key: const ValueKey(
                                                  'products-list',
                                                ),
                                                children: _buildProductCards(
                                                  visibleProducts,
                                                  ProductCardLayout.list,
                                                ),
                                              ),
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
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  String _formatPrice(num value) {
    return '₡ ${_currencyFormat.format(value).replaceAll('.', ' ')}';
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
          category: product.categoryName,
          productIcon: ProductCategoryIconHelper.resolve(product.categoryName),
          isActive: product.isActive,
          onEdit: () {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (_) => BlocProvider.value(
                value: context.read<ProductsBloc>(),
                child: AddProductDialog(product: product),
              ),
            );
          },
          onDelete: () => _confirmDeleteProduct(product),
        ),
    ];
  }

  Future<void> _confirmDeleteProduct(ProductsEntity product) async {
    final localizations = AppLocalizations.of(context)!;
    final shouldDelete = await showAppConfirmationDialog(
      context: context,
      title: localizations.delete_product_dialog_title,
      message: localizations.delete_product_dialog_message,
      confirmLabel: localizations.delete_action,
    );

    if (shouldDelete != true || !mounted) {
      return;
    }

    context.read<ProductsBloc>().add(DeleteProductEvent(id: product.id));
  }

  List<ProductsEntity> _applyFilters({
    required List<ProductsEntity> products,
    required int? selectedCategoryId,
  }) {
    final normalizedQuery = _searchQuery.trim().toLowerCase();

    return products.where((product) {
      final matchesCategory =
          selectedCategoryId == null ||
          product.categoryId == selectedCategoryId;
      final matchesSearch =
          normalizedQuery.isEmpty ||
          product.name.toLowerCase().contains(normalizedQuery) ||
          product.description.toLowerCase().contains(normalizedQuery) ||
          product.categoryName.toLowerCase().contains(normalizedQuery);

      return matchesCategory && matchesSearch;
    }).toList();
  }
}
