import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nativus_pos_desktop/core/enums/sidebar_options_enum.dart';
import 'package:nativus_pos_desktop/features/app_shell/presentation/pages/app_shell_page.dart';
import 'package:nativus_pos_desktop/features/app_shell/presentation/pages/menu_placeholder_page.dart';
import 'package:nativus_pos_desktop/features/app_shell/presentation/pages/point_of_sale_page.dart';
import 'package:nativus_pos_desktop/features/auth/presentation/pages/login_page.dart';
import 'package:nativus_pos_desktop/l10n/app_localizations.dart';

import 'route_names.dart';

typedef RouteLabelBuilder = String Function(AppLocalizations localizations);
typedef AppRouteBuilder = Widget Function(
  BuildContext context,
  GoRouterState state,
);

class AppRouter {
  AppRouter._();

  static final GlobalKey<NavigatorState> rootNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'rootNavigator');
  static final GlobalKey<NavigatorState> shellNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'shellNavigator');

  static final List<ShellNavigationItem> shellDestinations = [
    ShellNavigationItem(
      section: MenuSection.dashboard,
      routeName: RouteNames.dashboard,
      path: RoutePaths.dashboard,
      icon: Icons.home_outlined,
      label: (localizations) => localizations.sidebarDashboard,
      builder: (_, _) => const MenuPlaceholderPage(
        section: MenuSection.dashboard,
      ),
    ),
    ShellNavigationItem(
      section: MenuSection.pointOfSale,
      routeName: RouteNames.pointOfSale,
      path: RoutePaths.pointOfSale,
      icon: Icons.attach_money_rounded,
      label: (localizations) => localizations.sidebarPointOfSale,
      builder: (_, _) => const PointOfSalePage(),
    ),
    ShellNavigationItem(
      section: MenuSection.tableManagement,
      routeName: RouteNames.tableManagement,
      path: RoutePaths.tableManagement,
      icon: Icons.table_restaurant_outlined,
      label: (localizations) => localizations.sidebarTableManagement,
      builder: (_, _) => const MenuPlaceholderPage(
        section: MenuSection.tableManagement,
      ),
    ),
    ShellNavigationItem(
      section: MenuSection.products,
      routeName: RouteNames.products,
      path: RoutePaths.products,
      icon: Icons.inventory_2_outlined,
      label: (localizations) => localizations.sidebarProducts,
      builder: (_, _) => const MenuPlaceholderPage(
        section: MenuSection.products,
      ),
    ),
    ShellNavigationItem(
      section: MenuSection.reports,
      routeName: RouteNames.reports,
      path: RoutePaths.reports,
      icon: Icons.bar_chart_rounded,
      label: (localizations) => localizations.sidebarReports,
      builder: (_, _) => const MenuPlaceholderPage(
        section: MenuSection.reports,
      ),
    ),
    ShellNavigationItem(
      section: MenuSection.settings,
      routeName: RouteNames.settings,
      path: RoutePaths.settings,
      icon: Icons.settings_outlined,
      label: (localizations) => localizations.sidebarSettings,
      builder: (_, _) => const MenuPlaceholderPage(
        section: MenuSection.settings,
      ),
    ),
  ];

  static GoRouter createRouter() {
    return GoRouter(
      navigatorKey: rootNavigatorKey,
      initialLocation: RoutePaths.login,
      routes: [
        GoRoute(
          path: RoutePaths.login,
          name: RouteNames.login,
          builder: (context, state) => const LoginPage(),
        ),
        ShellRoute(
          navigatorKey: shellNavigatorKey,
          builder: (context, state, child) => AppShellPage(
            location: state.uri.path,
            child: child,
          ),
          routes: shellDestinations.map(_buildShellRoute).toList(),
        ),
      ],
    );
  }

  static bool isRouteSelected({
    required String currentLocation,
    required String targetLocation,
  }) {
    return currentLocation == targetLocation ||
        currentLocation.startsWith('$targetLocation/');
  }

  static GoRoute _buildShellRoute(ShellNavigationItem destination) {
    return GoRoute(
      path: destination.path,
      name: destination.routeName,
      builder: destination.builder,
      routes: destination.routes,
    );
  }
}

class ShellNavigationItem {
  const ShellNavigationItem({
    required this.section,
    required this.routeName,
    required this.path,
    required this.icon,
    required this.label,
    required this.builder,
    this.routes = const [],
  });

  final MenuSection section;
  final String routeName;
  final String path;
  final IconData icon;
  final RouteLabelBuilder label;
  final AppRouteBuilder builder;
  final List<RouteBase> routes;
}
