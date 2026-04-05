import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nativus_pos_desktop/application/theme/theme.dart';
import 'package:nativus_pos_desktop/features/products/domain/entities/products_entity.dart';
import 'package:nativus_pos_desktop/features/products/presentation/blocs/products_bloc.dart';
import 'package:nativus_pos_desktop/features/products/presentation/helpers/product_price_helper.dart';
import 'package:nativus_pos_desktop/l10n/app_localizations.dart';
import 'package:nativus_pos_desktop/shared/widgets/toasts/app_toast.dart';

class AddProductDialog extends StatefulWidget {
  final ProductsEntity? product;

  const AddProductDialog({super.key, this.product});

  @override
  State<AddProductDialog> createState() => _AddProductDialogState();
}

class _AddProductDialogState extends State<AddProductDialog> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameCtrl;
  late final TextEditingController _priceCtrl;
  late final TextEditingController _descCtrl;
  bool get _isEditing => widget.product != null;
  bool _isActive = true;
  int? _selectedCategoryId;

  @override
  void initState() {
    super.initState();
    final p = widget.product;
    _nameCtrl = TextEditingController(text: p?.name ?? '');
    _priceCtrl = TextEditingController(
      text: ProductPriceHelper.formatEditablePrice(p?.price),
    );
    _descCtrl = TextEditingController(text: p?.description ?? '');
    _isActive = p?.isActive ?? true;
    _selectedCategoryId = p?.categoryId;
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _priceCtrl.dispose();
    _descCtrl.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate() || _selectedCategoryId == null) {
      return;
    }

    if (_isEditing) {
      context.read<ProductsBloc>().add(
        UpdateProductEvent(
          id: widget.product!.id,
          categoryId: _selectedCategoryId!,
          name: _nameCtrl.text.trim(),
          description: _descCtrl.text.trim(),
          price: double.tryParse(_priceCtrl.text) ?? 0.0,
          isActive: _isActive,
        ),
      );
    } else {
      context.read<ProductsBloc>().add(
        AddProductEvent(
          categoryId: _selectedCategoryId!,
          name: _nameCtrl.text.trim(),
          description: _descCtrl.text.trim(),
          price: double.tryParse(_priceCtrl.text) ?? 0.0,
          isActive: _isActive,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context)!;

    return BlocListener<ProductsBloc, ProductsState>(
      listenWhen: (previous, current) =>
          previous.isLoading && !current.isLoading,
      listener: (context, state) {
        if (state is ProductAdded) {
          // Show success message
          AppToast.show(
            context,
            message: l10n.message_product_added,
            borderColor: colorScheme.baseGreen,
          );

          Navigator.of(context).pop();
        } else if (state is ProductUpdated) {
          // Show success message
          AppToast.show(
            context,
            message: l10n.message_product_updated,
            borderColor: colorScheme.baseGreen,
          );

          Navigator.of(context).pop();
        } else if (state is ProductError) {
          AppToast.show(
            context,
            message: state.errorMessage,
            borderColor: colorScheme.error,
          );
        }
      },
      child: Dialog(
        backgroundColor: colorScheme.darkSurface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: Container(
          width: 560,
          padding: const EdgeInsets.all(28),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _isEditing ? l10n.edit_product : l10n.new_product,
                      style: TextStyle(
                        color: colorScheme.baseWhite,
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: Icon(
                        Icons.close_rounded,
                        color: colorScheme.textMuted,
                      ),
                      style: IconButton.styleFrom(
                        backgroundColor: colorScheme.darkSurfaceAlt,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),

                Row(
                  children: [
                    Expanded(
                      child: _Field(
                        label: l10n.add_product_name_label,
                        child: TextFormField(
                          controller: _nameCtrl,
                          style: TextStyle(color: colorScheme.baseWhite),
                          decoration: _decor(
                            context,
                            l10n.add_product_name_hint,
                          ),
                          validator: (v) => v!.trim().isEmpty ? '' : null,
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: _Field(
                        label: l10n.add_product_price_label,
                        child: TextFormField(
                          controller: _priceCtrl,
                          style: TextStyle(color: colorScheme.baseWhite),
                          keyboardType: const TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                              RegExp(r'^\d*\.?\d*'),
                            ),
                          ],
                          decoration: _decor(
                            context,
                            l10n.add_product_price_hint,
                          ),
                          validator: (v) =>
                              (v == null ||
                                  v.trim().isEmpty ||
                                  double.tryParse(v) == null)
                              ? ''
                              : null,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                BlocBuilder<ProductsBloc, ProductsState>(
                  builder: (context, state) {
                    final categories = state.productCategories ?? [];
                    // Validate selected ID actually exists in new categories list
                    if (categories.isNotEmpty && _selectedCategoryId == null) {
                      _selectedCategoryId = categories.first.id;
                    }

                    return _Field(
                      label: l10n.add_product_category_label,
                      child: DropdownButtonFormField<int>(
                        initialValue: _selectedCategoryId,
                        menuMaxHeight: 300,
                        dropdownColor: colorScheme.darkSurfaceAlt,
                        style: TextStyle(
                          color: colorScheme.baseWhite,
                          fontSize: 16,
                        ),
                        decoration: _decor(context, ''),
                        items: categories
                            .map(
                              (c) => DropdownMenuItem(
                                value: c.id,
                                child: Text(c.name),
                              ),
                            )
                            .toList(),
                        onChanged: (v) =>
                            setState(() => _selectedCategoryId = v),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 20),

                _Field(
                  label: l10n.add_product_description_label,
                  child: TextFormField(
                    controller: _descCtrl,
                    maxLines: 4,
                    style: TextStyle(color: colorScheme.baseWhite),
                    decoration: _decor(
                      context,
                      l10n.add_product_description_hint,
                    ),
                  ),
                ),
                const SizedBox(height: 28),

                Row(
                  children: [
                    Switch(
                      value: _isActive,
                      onChanged: (v) => setState(() => _isActive = v),
                      activeThumbColor: colorScheme.baseWhite,
                      activeTrackColor: colorScheme.accentPrimary,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      l10n.add_product_active_label,
                      style: TextStyle(
                        color: colorScheme.baseWhite,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 36),

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    OutlinedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 16,
                        ),
                        side: BorderSide(color: colorScheme.softBorder),
                      ),
                      child: Text(
                        l10n.add_product_cancel_button,
                        style: TextStyle(
                          color: colorScheme.baseWhite,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    ElevatedButton(
                      onPressed: _submit,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colorScheme.accentPrimary,
                        foregroundColor: colorScheme.darkSurface,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 15,
                        ),
                      ),
                      child: Text(
                        _isEditing
                            ? l10n.message_save_changes
                            : l10n.add_product_submit_button,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration _decor(BuildContext context, String hint) {
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

class _Field extends StatelessWidget {
  final String label;
  final Widget child;
  const _Field({required this.label, required this.child});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: cs.textMuted,
            fontSize: 12,
            fontWeight: FontWeight.w800,
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 8),
        child,
      ],
    );
  }
}
