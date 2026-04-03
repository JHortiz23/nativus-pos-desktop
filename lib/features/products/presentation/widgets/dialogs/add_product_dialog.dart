import 'package:flutter/material.dart';
import 'package:nativus_pos_desktop/application/theme/theme.dart';
import 'package:nativus_pos_desktop/l10n/app_localizations.dart';

class AddProductDialog extends StatefulWidget {
  const AddProductDialog({super.key});

  @override
  State<AddProductDialog> createState() => _AddProductDialogState();
}

class _AddProductDialogState extends State<AddProductDialog> {
  final _formKey = GlobalKey<FormState>();
  bool _isActive = true;
  String _selectedCategory = 'Bebidas';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final localizations = AppLocalizations.of(context)!;

    return Dialog(
      backgroundColor: colorScheme.darkSurface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
        side: BorderSide(color: colorScheme.softBorder),
      ),
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
                    localizations.new_product,
                    style: theme.textTheme.headlineMedium?.copyWith(
                      color: colorScheme.baseWhite,
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: Icon(Icons.close_rounded, color: colorScheme.textMuted),
                    style: IconButton.styleFrom(
                      backgroundColor: colorScheme.darkSurfaceAlt,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),

              // Name and Price fields
              Row(
                children: [
                  Expanded(
                    child: _buildFormField(
                      context: context,
                      label: localizations.add_product_name_label,
                      child: TextFormField(
                        style: TextStyle(color: colorScheme.baseWhite),
                        decoration: _inputDecoration(context, localizations.add_product_name_hint),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: _buildFormField(
                      context: context,
                      label: localizations.add_product_price_label,
                      child: TextFormField(
                        initialValue: '12500',
                        style: TextStyle(color: colorScheme.baseWhite),
                        keyboardType: TextInputType.number,
                        decoration: _inputDecoration(context, localizations.add_product_price_hint),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Category Dropdown
              _buildFormField(
                context: context,
                label: localizations.add_product_category_label,
                child: DropdownButtonFormField<String>(
                  initialValue: _selectedCategory,
                  dropdownColor: colorScheme.darkSurfaceAlt,
                  style: TextStyle(color: colorScheme.baseWhite, fontSize: 16),
                  icon: Icon(Icons.arrow_drop_down, color: colorScheme.textMuted),
                  decoration: _inputDecoration(context, '').copyWith(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  ),
                  items: [
                    DropdownMenuItem(
                      value: 'Bebidas',
                      child: Row(
                        children: [
                          const Text('🍹', style: TextStyle(fontSize: 18)),
                          const SizedBox(width: 8),
                          Text(
                            localizations.add_product_category_drinks,
                            style: TextStyle(color: colorScheme.baseWhite, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                    DropdownMenuItem(
                      value: 'Comidas',
                      child: Row(
                        children: [
                          const Text('🍔', style: TextStyle(fontSize: 18)),
                          const SizedBox(width: 8),
                          Text(
                            localizations.add_product_category_food,
                            style: TextStyle(color: colorScheme.baseWhite, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                  ],
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        _selectedCategory = value;
                      });
                    }
                  },
                ),
              ),
              const SizedBox(height: 20),

              // Description Text Area
              _buildFormField(
                context: context,
                label: localizations.add_product_description_label,
                child: TextFormField(
                  maxLines: 4,
                  style: TextStyle(color: colorScheme.baseWhite),
                  decoration: _inputDecoration(context, localizations.add_product_description_hint),
                ),
              ),
              const SizedBox(height: 28),

              // Switch Product Active
              Row(
                children: [
                  Switch(
                    value: _isActive,
                    onChanged: (value) {
                      setState(() {
                        _isActive = value;
                      });
                    },
                    activeThumbColor: colorScheme.baseWhite,
                    activeTrackColor: colorScheme.accentPrimary,
                    inactiveThumbColor: colorScheme.textMuted,
                    inactiveTrackColor: colorScheme.darkSurfaceAlt,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    localizations.add_product_active_label,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: colorScheme.baseWhite,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 36),

              // Action Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  OutlinedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                      side: BorderSide(color: colorScheme.softBorder),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      localizations.add_product_cancel_button,
                      style: TextStyle(
                        color: colorScheme.baseWhite,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: () {
                      // Create product action
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colorScheme.accentPrimary,
                      foregroundColor: colorScheme.darkSurface,
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      localizations.add_product_submit_button,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFormField({
    required BuildContext context,
    required String label,
    required Widget child,
  }) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: theme.textTheme.labelMedium?.copyWith(
            color: colorScheme.textMuted,
            fontWeight: FontWeight.w800,
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 8),
        child,
      ],
    );
  }

  InputDecoration _inputDecoration(BuildContext context, String hintText) {
    final colorScheme = Theme.of(context).colorScheme;
    return InputDecoration(
      hintText: hintText,
      hintStyle: TextStyle(color: colorScheme.textMuted.withValues(alpha: 0.5)),
      filled: true,
      fillColor: colorScheme.darkSurfaceAlt,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: colorScheme.softBorder),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: colorScheme.softBorder),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: colorScheme.accentPrimary),
      ),
    );
  }
}
