import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nativus_pos_desktop/application/theme/theme.dart';
import 'package:nativus_pos_desktop/shared/widgets/inputs/custom_input_decoration.dart';

class CustomNumberField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final String hint;
  final bool allowDecimal;
  final bool readOnly;

  const CustomNumberField({
    super.key,
    required this.label,
    required this.controller,
    required this.hint,
    this.allowDecimal = false,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    
    final decoration = CustomInputDecoration.decor(context, hint);

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
        TextFormField(
          controller: controller,
          readOnly: readOnly,
          style: TextStyle(color: readOnly ? cs.textMuted : cs.baseWhite),
          keyboardType: TextInputType.numberWithOptions(
            decimal: allowDecimal,
          ),
          inputFormatters: [
            if (allowDecimal)
              FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*'))
            else
              FilteringTextInputFormatter.digitsOnly,
          ],
          decoration: decoration,
          validator: (v) {
            if (v == null || v.trim().isEmpty) return '';
            if (allowDecimal) {
              return double.tryParse(v) == null ? '' : null;
            } else {
              return int.tryParse(v) == null ? '' : null;
            }
          },
        ),
      ],
    );
  }
}
