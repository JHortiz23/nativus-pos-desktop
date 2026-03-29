// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Nativus POS';

  @override
  String get loginBrandSubtitle => 'Point of Sale System';

  @override
  String get loginTitle => 'Sign In';

  @override
  String get loginSubtitle => 'Enter your credentials to continue';

  @override
  String get loginUsernameLabel => 'Username';

  @override
  String get loginUsernameHint => 'Enter your username';

  @override
  String get loginPasswordLabel => 'Password';

  @override
  String get loginPasswordHint => 'Enter your password';

  @override
  String get loginSubmitButton => 'Sign In';

  @override
  String get sidebarBrandSubtitle => 'Point of Sale System';

  @override
  String get sidebarDashboard => 'Dashboard';

  @override
  String get sidebarPointOfSale => 'Point of Sale';

  @override
  String get sidebarTableManagement => 'Table Management';

  @override
  String get sidebarProducts => 'Products';

  @override
  String get sidebarReports => 'Reports';

  @override
  String get sidebarSettings => 'Settings';

  @override
  String get sidebarLogout => 'Log Out';

  @override
  String get sidebarAdminName => 'Admin';

  @override
  String get sidebarAdminRole => 'Administrator';

  @override
  String get sidebarCollapse => 'Collapse menu';

  @override
  String get sidebarExpand => 'Expand menu';

  @override
  String get exampleEyebrow => 'Example view';

  @override
  String get modulePlaceholderDescription => 'This module is still under construction. The sidebar already navigates and renders content in this area.';

  @override
  String get modulePlaceholderCardText => 'The final screen for this module will be displayed here once it is implemented.';

  @override
  String get pointOfSaleExampleTitle => 'Point of Sale';

  @override
  String get pointOfSaleExampleDescription => 'Example base screen to demonstrate how the main content area renders when a sidebar option is selected.';

  @override
  String get pointOfSaleMetricSales => 'Sales today';

  @override
  String get pointOfSaleMetricRevenue => 'Revenue';

  @override
  String get pointOfSaleMetricTables => 'Active tables';

  @override
  String get pointOfSaleRecentOrders => 'Recent orders';

  @override
  String get pointOfSaleQuickActions => 'Quick actions';

  @override
  String get pointOfSaleNewSale => 'Create new sale';

  @override
  String get pointOfSaleViewTickets => 'View tickets';

  @override
  String get pointOfSaleAssignTable => 'Assign table';

  @override
  String get pointOfSaleOrderTable4 => 'Table 4';

  @override
  String get pointOfSaleOrderCounter => 'Counter';

  @override
  String get pointOfSaleOrderTable2 => 'Table 2';

  @override
  String get orderStatusPaid => 'Paid';

  @override
  String get orderStatusPending => 'Pending';

  @override
  String get orderStatusPreparing => 'Preparing';

  @override
  String get search_product => 'Search Product...';

  @override
  String get no_products_found => 'There are not products to show';

  @override
  String get empty_products_try_other_category => 'Try another category to see available mock items.';

  @override
  String get empty_products_no_matches => 'We did not find matches for your current search.';

  @override
  String get product_card_inactive_caps => 'INACTIVE';

  @override
  String get product_card_status_active => 'Active';

  @override
  String get product_card_status_inactive => 'Inactive';
}
