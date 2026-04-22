import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nativus_pos_desktop/application/theme/theme.dart';
import 'package:nativus_pos_desktop/features/tables/domain/entities/dining_area_entity.dart';
import 'package:nativus_pos_desktop/features/tables/presentation/blocs/tables_bloc.dart';
import 'package:nativus_pos_desktop/l10n/app_localizations.dart';
import 'package:nativus_pos_desktop/shared/widgets/toasts/app_toast.dart';
import 'package:nativus_pos_desktop/shared/widgets/inputs/custom_field.dart';
import 'package:nativus_pos_desktop/shared/widgets/inputs/custom_number_field.dart';
import 'package:nativus_pos_desktop/shared/widgets/inputs/custom_input_decoration.dart';

class AddDiningAreaDialog extends StatefulWidget {
  final DiningAreaEntity? diningArea;

  const AddDiningAreaDialog({super.key, this.diningArea});

  @override
  State<AddDiningAreaDialog> createState() => _AddDiningAreaDialogState();
}

class _AddDiningAreaDialogState extends State<AddDiningAreaDialog> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameCtrl;
  late final TextEditingController _tablesCtrl;
  late AppLocalizations _l10n;
  bool get _isEditing => widget.diningArea != null;
  late bool _isActive;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _l10n = AppLocalizations.of(context)!;
  }

  @override
  void initState() {
    super.initState();
    final diningArea = widget.diningArea;
    _nameCtrl = TextEditingController(text: diningArea?.name ?? '');
    _tablesCtrl = TextEditingController(
      text: diningArea?.tablesCount.toString() ?? '',
    );
    _isActive = diningArea?.isActive ?? true;
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _tablesCtrl.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (_isEditing) {
      //Update existing table
      // context.read<TablesBloc>().add(
      //   UpdateTableEvent(
      //     id: widget.diningArea!.id,
      //     name: _nameCtrl.text.trim(),
      //     seats: int.parse(_tablesCtrl.text.trim()),
      //     // diningAreaId: _selectedDiningAreaId!,
      //     isActive: _isActive,
      //   ),
      // );
    } else {
      // Add new dining area
      context.read<TablesBloc>().add(
        AddDiningAreaEvent(
          name: _nameCtrl.text.trim(),
          isActive: _isActive,
          tables: int.parse(_tablesCtrl.text.trim()),
          tableName: _l10n.table_name_label,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return BlocListener<TablesBloc, TablesState>(
      listenWhen: (previous, current) =>
          previous.isLoading && !current.isLoading,
      listener: (context, state) {
        if (state is DiningAreaAdded) {
          // Show success message
          AppToast.show(
            context,
            message: _l10n.message_salon_added,
            borderColor: colorScheme.baseGreen,
          );
          Navigator.of(context).pop();
        } else if (state is TableUpdated) {
          // Show success message
          AppToast.show(
            context,
            message: _l10n.message_table_updated,
            borderColor: colorScheme.baseGreen,
          );

          Navigator.of(context).pop();
        } else if (state is TableError) {
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
                      _isEditing
                          ? _l10n.edit_dining_area
                          : _l10n.table_management_new_dining_area,
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
                      child: CustomField(
                        label: _l10n.add_product_name_label,
                        child: TextFormField(
                          controller: _nameCtrl,
                          style: TextStyle(color: colorScheme.baseWhite),
                          decoration: CustomInputDecoration.decor(
                            context,
                            _l10n.add_salon_name_hint,
                          ),
                          validator: (v) => v!.trim().isEmpty ? '' : null,
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: CustomNumberField(
                        label: _l10n.tables_label.toUpperCase(),
                        controller: _tablesCtrl,
                        hint: _l10n.add_product_price_hint,
                        allowDecimal: false, // Si es false, solo enteros
                        readOnly: _isEditing,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),

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
                      _l10n.active_dining_area_label,
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
                        _l10n.add_product_cancel_button,
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
                            ? _l10n.message_save_changes
                            : _l10n.create_label,
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
}
