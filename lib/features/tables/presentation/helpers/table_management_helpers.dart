import 'package:flutter/material.dart';
import 'package:nativus_pos_desktop/application/theme/theme.dart';
import 'package:nativus_pos_desktop/core/enums/status_enums.dart';
import 'package:nativus_pos_desktop/features/tables/domain/entities/table_entity.dart';
import 'package:nativus_pos_desktop/l10n/app_localizations.dart';

String displayTableName(TableEntity table, AppLocalizations localizations) {
  final extractedNumber = _extractTableNumber(table.name);
  if (extractedNumber != null || table.name.trim().isEmpty) {
    return localizations.table_management_table_name(
      extractedNumber ?? table.id,
    );
  }

  return table.name;
}

int tableNumber(TableEntity table) {
  return _extractTableNumber(table.name) ?? table.id;
}

TableStatus tableStatus(TableEntity table) {
  final normalized = table.status.trim().toLowerCase();
  const availableKeywords = {'available', 'disponible', 'free', 'open'};

  if (availableKeywords.any(normalized.contains)) {
    return TableStatus.disponible;
  }

  return TableStatus.ocupada;
}

Color diningAreaAccentColor(ColorScheme colorScheme) {
  return colorScheme.accentPrimary;
}

int? _extractTableNumber(String value) {
  final matches = RegExp(r'\d+').allMatches(value).toList(growable: false);
  if (matches.isEmpty) {
    return null;
  }

  return int.tryParse(matches.last.group(0) ?? '');
}
