import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nativus_pos_desktop/application/theme/theme.dart';
import 'package:nativus_pos_desktop/features/tables/domain/entities/table_entity.dart';
import 'package:nativus_pos_desktop/features/tables/presentation/blocs/tables_bloc.dart';
import 'package:nativus_pos_desktop/l10n/app_localizations.dart';
import 'package:nativus_pos_desktop/shared/widgets/toasts/app_toast.dart';
import 'package:nativus_pos_desktop/shared/widgets/inputs/custom_field.dart';
import 'package:nativus_pos_desktop/shared/widgets/inputs/custom_number_field.dart';
import 'package:nativus_pos_desktop/shared/widgets/inputs/custom_input_decoration.dart';

class AddTableDialog extends StatefulWidget {
  final TableEntity? table;

  const AddTableDialog({super.key, this.table});

  @override
  State<AddTableDialog> createState() => _AddTableDialogState();
}

class _AddTableDialogState extends State<AddTableDialog> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameCtrl;
  late final TextEditingController _seatsCtrl;
  bool get _isEditing => widget.table != null;
  late bool _isActive;
  int? _selectedDiningAreaId;

  @override
  void initState() {
    super.initState();
    final t = widget.table;
    _nameCtrl = TextEditingController(text: t?.name ?? '');
    _seatsCtrl = TextEditingController(text: t?.seats.toString() ?? '');
    _isActive = t?.isActive ?? true;
    _selectedDiningAreaId = t?.diningAreaId;
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _seatsCtrl.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate() || _selectedDiningAreaId == null) {
      return;
    }

    if (_isEditing) {
      //Update existing table
      context.read<TablesBloc>().add(
        UpdateTableEvent(
          id: widget.table!.id,
          name: _nameCtrl.text.trim(),
          seats: int.parse(_seatsCtrl.text.trim()),
          diningAreaId: _selectedDiningAreaId!,
          isActive: _isActive,
        ),
      );
    } else {
      // Add new table
      context.read<TablesBloc>().add(
        AddTableEvent(
          name: _nameCtrl.text.trim(),
          seats: int.parse(_seatsCtrl.text.trim()),
          diningAreaId: _selectedDiningAreaId!,
          isActive: _isActive,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context)!;

    return BlocListener<TablesBloc, TablesState>(
      listenWhen: (previous, current) =>
          previous.isLoading && !current.isLoading,
      listener: (context, state) {
        if (state is TableAdded) {
          // Show success message
          AppToast.show(
            context,
            message: l10n.message_table_added,
            borderColor: colorScheme.baseGreen,
          );

          Navigator.of(context).pop();
        } else if (state is TableUpdated) {
          // Show success message
          AppToast.show(
            context,
            message: l10n.message_table_updated,
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
                          ? l10n.edit_table
                          : l10n.table_management_new_table,
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
                        label: l10n.add_product_name_label,
                        child: TextFormField(
                          controller: _nameCtrl,
                          style: TextStyle(color: colorScheme.baseWhite),
                          decoration: CustomInputDecoration.decor(
                            context,
                            l10n.add_table_name_hint,
                          ),
                          validator: (v) => v!.trim().isEmpty ? '' : null,
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: CustomNumberField(
                        label: l10n.seats.toUpperCase(),
                        controller: _seatsCtrl,
                        hint: l10n.add_product_price_hint,
                        allowDecimal: false, // Si es false, solo enteros
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                BlocBuilder<TablesBloc, TablesState>(
                  builder: (context, state) {
                    final diningAreas = state.diningAreas ?? [];

                    // Validate selected ID actually exists in new dining areas list
                    if (diningAreas.isNotEmpty &&
                        _selectedDiningAreaId == null) {
                      _selectedDiningAreaId = diningAreas.first.id;
                    }

                    return CustomField(
                      label: l10n.dining_area.toUpperCase(),
                      child: DropdownButtonFormField<int>(
                        initialValue: _selectedDiningAreaId,
                        menuMaxHeight: 300,
                        dropdownColor: colorScheme.darkSurfaceAlt,
                        style: TextStyle(
                          color: colorScheme.baseWhite,
                          fontSize: 16,
                        ),
                        decoration: CustomInputDecoration.decor(context, ''),
                        items: diningAreas
                            .map(
                              (c) => DropdownMenuItem(
                                value: c.id,
                                child: Text(c.name),
                              ),
                            )
                            .toList(),
                        onChanged: (v) =>
                            setState(() => _selectedDiningAreaId = v),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 20),

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
                      l10n.table_management_active_label,
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
                            : l10n.table_management_create_label,
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
