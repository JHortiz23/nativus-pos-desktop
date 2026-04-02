class Assets {
  // ** Asset Paths ** //
  static const String _svgPath = 'assets/svgs';
  static const String _pngPath = 'assets/pngs';
  static const String _iconPath = 'assets/icons';
  static const String _imagePath = 'assets/images';
  static const String _lottiePath = 'assets/lotties';

  // ** Get asset paths ** //
  static String getSvgPath(String fileName) => '$_svgPath/$fileName.svg';
  static String getPngPath(String fileName) => '$_pngPath/$fileName.png';
  static String getIconPath(String fileName) => '$_iconPath/$fileName.png';
  static String getImagePath(String fileName) => '$_imagePath/$fileName.png';
  static String getLottiePath(String fileName) => '$_lottiePath/$fileName.json';

  // ** SVGs ** //
  //static String dashboardMenuItem = getSvgPath('dashboard_menu_item');
  static String liquorIcon = getSvgPath('liquor_icon');
  static String productsMenuItem = getSvgPath('products_menu_item');

  // ** Icons ** //
  //static String writeIcon = getIconPath('write');

  // ** Logos ** //
  //static String brainFitLifeLogo = getPngPath('brain_fit_life_logo');

  // ** Images ** //
  //static String brainImage = getImagePath('brain');

  // ** Lotties ** //
  //static String loaderLottie = getLottiePath('loader');
}
