class ProductPriceHelper {
  static String formatEditablePrice(double? value) {
    if (value == null) return '';

    return value
        .toString()
        .replaceFirst(RegExp(r'(\.\d*?[1-9])0+$'), r'$1')
        .replaceFirst(RegExp(r'\.0+$'), '');
  }
}
