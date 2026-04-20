import 'package:flutter/material.dart';
import 'package:nativus_pos_desktop/application/theme/theme.dart';

class CustomField extends StatelessWidget {
  final String label;
  final Widget child;

  const CustomField({super.key, required this.label, required this.child});

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
