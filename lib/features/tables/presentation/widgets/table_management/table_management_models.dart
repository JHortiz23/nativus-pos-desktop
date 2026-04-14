import 'package:flutter/material.dart';
import 'package:nativus_pos_desktop/application/theme/theme.dart';
import 'package:nativus_pos_desktop/features/tables/domain/entities/dining_area_entity.dart';
import 'package:nativus_pos_desktop/features/tables/domain/entities/table_entity.dart';
import 'package:nativus_pos_desktop/features/tables/presentation/widgets/tables/table_card.dart';
import 'package:nativus_pos_desktop/l10n/app_localizations.dart';

class DiningAreaViewData {
  const DiningAreaViewData({
    required this.id,
    required this.name,
    required this.totalTables,
    required this.availableCount,
    required this.occupiedCount,
    required this.tables,
  });

  final int id;
  final String name;
  final int totalTables;
  final int availableCount;
  final int occupiedCount;
  final List<TableViewData> tables;
}

class TableViewData {
  const TableViewData({
    required this.id,
    required this.name,
    required this.number,
    required this.hasExtractedNumber,
    required this.capacity,
    required this.status,
  });

  final int id;
  final String name;
  final int number;
  final bool hasExtractedNumber;
  final int capacity;
  final TableStatus status;

  String displayName(AppLocalizations localizations) {
    if (hasExtractedNumber || name.trim().isEmpty) {
      return localizations.table_management_table_name(number);
    }
    return name;
  }
}

List<DiningAreaViewData> mapDiningAreas(List<DiningAreaEntity> diningAreas) {
  return diningAreas.map(_mapDiningArea).toList(growable: false);
}

DiningAreaViewData _mapDiningArea(DiningAreaEntity diningArea) {
  return DiningAreaViewData(
    id: diningArea.id,
    name: diningArea.name,
    totalTables: diningArea.tablesCount,
    availableCount: diningArea.availableCount,
    occupiedCount: diningArea.occupiedCount,
    tables: diningArea.tables.map(_mapTable).toList(growable: false),
  );
}

TableViewData _mapTable(TableEntity table) {
  final extractedNumber = _extractTableNumber(table.name);

  return TableViewData(
    id: table.id,
    name: table.name,
    number: extractedNumber ?? table.id,
    hasExtractedNumber: extractedNumber != null,
    capacity: table.seats ?? 0,
    status: _mapTableStatus(table.status),
  );
}

int? _extractTableNumber(String value) {
  final matches = RegExp(r'\d+').allMatches(value).toList(growable: false);
  if (matches.isEmpty) {
    return null;
  }

  return int.tryParse(matches.last.group(0) ?? '');
}

TableStatus _mapTableStatus(String status) {
  final normalized = status.trim().toLowerCase();
  const availableKeywords = {'available', 'disponible', 'free', 'open'};

  if (availableKeywords.any(normalized.contains)) {
    return TableStatus.disponible;
  }

  return TableStatus.ocupada;
}

Color diningAreaAccentColor(ColorScheme colorScheme) {
  return colorScheme.accentPrimary;
}
