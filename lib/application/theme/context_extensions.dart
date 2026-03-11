import 'package:flutter/material.dart';

extension BuildContextColorScheme on BuildContext {
  ColorScheme get cs => Theme.of(this).colorScheme;
}
