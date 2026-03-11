// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';

// class Assets {
//   // ** Asset Paths ** //
//   static const String _svgPath = 'assets/svgs';
//   static const String _pngPath = 'assets/pngs';
//   static const String _iconPath = 'assets/icons';
//   static const String _imagePath = 'assets/images';
//   static const String _lottiePath = 'assets/lotties';

//   // ** Get asset paths ** //
//   static String getSvgPath(String fileName) => '$_svgPath/$fileName.svg';
//   static String getPngPath(String fileName) => '$_pngPath/$fileName.png';
//   static String getIconPath(String fileName) => '$_iconPath/$fileName.png';
//   static String getImagePath(String fileName) => '$_imagePath/$fileName.png';
//   static String getLottiePath(String fileName) => '$_lottiePath/$fileName.json';

//   static String dashboardMenuItem = getSvgPath('dashboard_menu_item');
//   static String submissionsMenuItem = getSvgPath('submissions_menu_item');
//   static String productsMenuItem = getSvgPath('products_menu_item');
//   static String activitiesMenuItem = getSvgPath('activities_menu_item');
//   static String userReviewsMenuItem = getSvgPath('user_reviews_menu_item');
//   static String searchIcon = getSvgPath('search_icon');

//   // ** Icons ** //
//   static String writeIcon = getIconPath('write');
//   static String brainFitLifeIcon = getPngPath('brain_fit_life_icon');
//   static String scanIcon = getIconPath('scan');
//   static String greenCheckIcon = getIconPath('green_check');
//   static String closeIcon = getIconPath('close');
//   static String loaderIcon = getIconPath('loader');
//   static String hideImage = getIconPath('hide_image');
//   static String checkIcon = getSvgPath('check');

//   // ** Logos ** //
//   static String brainFitLifeLogo = getPngPath('brain_fit_life_logo');

//   // ** Images ** //
//   static String brainImage = getImagePath('brain');

//   // ** Lotties ** //
//   static String loaderLottie = getLottiePath('loader');

//   static Future<void> _precacheSvg(String assetPath) async {
//     try {
//       final loader = SvgAssetLoader(assetPath);
//       await svg.cache.putIfAbsent(
//         loader.cacheKey(null),
//         () => loader.loadBytes(null),
//       );
//     } catch (e) {
//       debugPrint('Error to load svg asset: $assetPath: $e');
//     }
//   }

//   static Future<void> precacheAllSvgs() async {
//     await Future.wait([
//       _precacheSvg(dashboardMenuItem),
//       _precacheSvg(submissionsMenuItem),
//       _precacheSvg(productsMenuItem),
//       _precacheSvg(activitiesMenuItem),
//       _precacheSvg(userReviewsMenuItem),
//       _precacheSvg(searchIcon),
//     ]);
//   }
// }
