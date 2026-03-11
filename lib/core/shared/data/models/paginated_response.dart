class PageInfo {
  final int total;
  final int page;
  final int pageSize;

  const PageInfo({
    required this.total,
    required this.page,
    required this.pageSize,
  });

  factory PageInfo.fromJson(Map<String, dynamic> json) => PageInfo(
    total: (json['total'] ?? 0) as int,
    page: (json['page'] ?? 1) as int,
    pageSize: (json['page_size'] ?? json['pageSize'] ?? 100) as int,
  );

  int get totalPages =>
      pageSize == 0 ? 0 : ((total + pageSize - 1) / pageSize).floor();

  bool get hasNext => pageSize > 0 && page * pageSize < total;
  bool get hasPrev => page > 1;
}

class PaginatedResponse<T> {
  final List<T> items;
  final PageInfo pageInfo;
  final Map<String, dynamic>? filters;
  final String detectedItemsKey;

  const PaginatedResponse({
    required this.items,
    required this.pageInfo,
    this.filters,
    required this.detectedItemsKey,
  });

  factory PaginatedResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) fromJsonT, {
    String? itemsKey,
    List<String> candidateKeys = const [
      'items',
      'results',
      'data',
      'records',
      'list',
      'products',
      'submissions',
    ],
    String filtersKey = 'applied_filters',
  }) {
    // use the provided itemsKey first
    String? key = itemsKey;

    // 2) check candidate keys
    key ??= candidateKeys.firstWhere((k) => json[k] is List, orElse: () => '');

    // 3) fallback: first key with a List value
    if (key.isEmpty) {
      for (final entry in json.entries) {
        if (entry.value is List) {
          key = entry.key;
          break;
        }
      }
    }

    if (key == null || key.isEmpty || json[key] is! List) {
      throw StateError(
        'PagedResponse: itemsKey not found in JSON.'
        'Pass itemsKey or adjust candidateKeys.',
      );
    }

    final rawList = (json[key] as List?) ?? const [];
    final items = rawList
        .whereType<Map<String, dynamic>>()
        .map(fromJsonT)
        .toList(growable: false);

    final pageInfo = PageInfo.fromJson(json);

    final Map<String, dynamic>? filters =
        json[filtersKey] is Map<String, dynamic>
        ? (json[filtersKey] as Map<String, dynamic>)
        : null;

    return PaginatedResponse<T>(
      items: items,
      pageInfo: pageInfo,
      filters: filters,
      detectedItemsKey: key,
    );
  }
}
