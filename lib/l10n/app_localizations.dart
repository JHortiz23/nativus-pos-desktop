import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es')
  ];

  /// Application title displayed in window titles and SEO metadata.
  ///
  /// In en, this message translates to:
  /// **'Nativus POS'**
  String get appTitle;

  /// No description provided for @loginBrandSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Point of Sale System'**
  String get loginBrandSubtitle;

  /// No description provided for @loginTitle.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get loginTitle;

  /// No description provided for @loginSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Enter your credentials to continue'**
  String get loginSubtitle;

  /// No description provided for @loginUsernameLabel.
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get loginUsernameLabel;

  /// No description provided for @loginUsernameHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your username'**
  String get loginUsernameHint;

  /// No description provided for @loginPasswordLabel.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get loginPasswordLabel;

  /// No description provided for @loginPasswordHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your password'**
  String get loginPasswordHint;

  /// No description provided for @loginSubmitButton.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get loginSubmitButton;

  /// No description provided for @sidebarBrandSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Point of Sale System'**
  String get sidebarBrandSubtitle;

  /// No description provided for @sidebarDashboard.
  ///
  /// In en, this message translates to:
  /// **'Dashboard'**
  String get sidebarDashboard;

  /// No description provided for @sidebarPointOfSale.
  ///
  /// In en, this message translates to:
  /// **'Point of Sale'**
  String get sidebarPointOfSale;

  /// No description provided for @sidebarTableManagement.
  ///
  /// In en, this message translates to:
  /// **'Table Management'**
  String get sidebarTableManagement;

  /// No description provided for @sidebarProducts.
  ///
  /// In en, this message translates to:
  /// **'Products'**
  String get sidebarProducts;

  /// No description provided for @sidebarReports.
  ///
  /// In en, this message translates to:
  /// **'Reports'**
  String get sidebarReports;

  /// No description provided for @sidebarSettings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get sidebarSettings;

  /// No description provided for @sidebarLogout.
  ///
  /// In en, this message translates to:
  /// **'Log Out'**
  String get sidebarLogout;

  /// No description provided for @sidebarAdminName.
  ///
  /// In en, this message translates to:
  /// **'Admin'**
  String get sidebarAdminName;

  /// No description provided for @sidebarAdminRole.
  ///
  /// In en, this message translates to:
  /// **'Administrator'**
  String get sidebarAdminRole;

  /// No description provided for @sidebarCollapse.
  ///
  /// In en, this message translates to:
  /// **'Collapse menu'**
  String get sidebarCollapse;

  /// No description provided for @sidebarExpand.
  ///
  /// In en, this message translates to:
  /// **'Expand menu'**
  String get sidebarExpand;

  /// No description provided for @exampleEyebrow.
  ///
  /// In en, this message translates to:
  /// **'Example view'**
  String get exampleEyebrow;

  /// No description provided for @modulePlaceholderDescription.
  ///
  /// In en, this message translates to:
  /// **'This module is still under construction. The sidebar already navigates and renders content in this area.'**
  String get modulePlaceholderDescription;

  /// No description provided for @modulePlaceholderCardText.
  ///
  /// In en, this message translates to:
  /// **'The final screen for this module will be displayed here once it is implemented.'**
  String get modulePlaceholderCardText;

  /// No description provided for @pointOfSaleExampleTitle.
  ///
  /// In en, this message translates to:
  /// **'Point of Sale'**
  String get pointOfSaleExampleTitle;

  /// No description provided for @pointOfSaleExampleDescription.
  ///
  /// In en, this message translates to:
  /// **'Example base screen to demonstrate how the main content area renders when a sidebar option is selected.'**
  String get pointOfSaleExampleDescription;

  /// No description provided for @pointOfSaleMetricSales.
  ///
  /// In en, this message translates to:
  /// **'Sales today'**
  String get pointOfSaleMetricSales;

  /// No description provided for @pointOfSaleMetricRevenue.
  ///
  /// In en, this message translates to:
  /// **'Revenue'**
  String get pointOfSaleMetricRevenue;

  /// No description provided for @pointOfSaleMetricTables.
  ///
  /// In en, this message translates to:
  /// **'Active tables'**
  String get pointOfSaleMetricTables;

  /// No description provided for @pointOfSaleRecentOrders.
  ///
  /// In en, this message translates to:
  /// **'Recent orders'**
  String get pointOfSaleRecentOrders;

  /// No description provided for @pointOfSaleQuickActions.
  ///
  /// In en, this message translates to:
  /// **'Quick actions'**
  String get pointOfSaleQuickActions;

  /// No description provided for @pointOfSaleNewSale.
  ///
  /// In en, this message translates to:
  /// **'Create new sale'**
  String get pointOfSaleNewSale;

  /// No description provided for @pointOfSaleViewTickets.
  ///
  /// In en, this message translates to:
  /// **'View tickets'**
  String get pointOfSaleViewTickets;

  /// No description provided for @pointOfSaleAssignTable.
  ///
  /// In en, this message translates to:
  /// **'Assign table'**
  String get pointOfSaleAssignTable;

  /// No description provided for @pointOfSaleOrderTable4.
  ///
  /// In en, this message translates to:
  /// **'Table 4'**
  String get pointOfSaleOrderTable4;

  /// No description provided for @pointOfSaleOrderCounter.
  ///
  /// In en, this message translates to:
  /// **'Counter'**
  String get pointOfSaleOrderCounter;

  /// No description provided for @pointOfSaleOrderTable2.
  ///
  /// In en, this message translates to:
  /// **'Table 2'**
  String get pointOfSaleOrderTable2;

  /// No description provided for @orderStatusPaid.
  ///
  /// In en, this message translates to:
  /// **'Paid'**
  String get orderStatusPaid;

  /// No description provided for @orderStatusPending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get orderStatusPending;

  /// No description provided for @orderStatusPreparing.
  ///
  /// In en, this message translates to:
  /// **'Preparing'**
  String get orderStatusPreparing;

  /// No description provided for @search_product.
  ///
  /// In en, this message translates to:
  /// **'Search Product...'**
  String get search_product;

  /// No description provided for @no_products_found.
  ///
  /// In en, this message translates to:
  /// **'There are not products to show'**
  String get no_products_found;

  /// No description provided for @empty_products_try_other_category.
  ///
  /// In en, this message translates to:
  /// **'Try another category to see available mock items.'**
  String get empty_products_try_other_category;

  /// No description provided for @empty_products_no_matches.
  ///
  /// In en, this message translates to:
  /// **'We did not find matches for your current search.'**
  String get empty_products_no_matches;

  /// No description provided for @product_card_inactive_caps.
  ///
  /// In en, this message translates to:
  /// **'INACTIVE'**
  String get product_card_inactive_caps;

  /// No description provided for @product_card_status_active.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get product_card_status_active;

  /// No description provided for @product_card_status_inactive.
  ///
  /// In en, this message translates to:
  /// **'Inactive'**
  String get product_card_status_inactive;

  /// No description provided for @all_label.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get all_label;

  /// No description provided for @product_management.
  ///
  /// In en, this message translates to:
  /// **'Product Management'**
  String get product_management;

  /// No description provided for @product_management_description.
  ///
  /// In en, this message translates to:
  /// **'Manage your catalog, categories, and the status of each product.'**
  String get product_management_description;

  /// No description provided for @product_label.
  ///
  /// In en, this message translates to:
  /// **'Product'**
  String get product_label;

  /// No description provided for @new_product.
  ///
  /// In en, this message translates to:
  /// **'New Product'**
  String get new_product;

  /// No description provided for @add_product_name_label.
  ///
  /// In en, this message translates to:
  /// **'NAME'**
  String get add_product_name_label;

  /// No description provided for @add_product_name_hint.
  ///
  /// In en, this message translates to:
  /// **'E.g.: Shrimp Ceviche'**
  String get add_product_name_hint;

  /// No description provided for @add_product_price_label.
  ///
  /// In en, this message translates to:
  /// **'PRICE (₡)'**
  String get add_product_price_label;

  /// No description provided for @add_product_price_hint.
  ///
  /// In en, this message translates to:
  /// **'0'**
  String get add_product_price_hint;

  /// No description provided for @add_product_category_label.
  ///
  /// In en, this message translates to:
  /// **'CATEGORY'**
  String get add_product_category_label;

  /// No description provided for @add_product_category_drinks.
  ///
  /// In en, this message translates to:
  /// **'Drinks'**
  String get add_product_category_drinks;

  /// No description provided for @add_product_category_food.
  ///
  /// In en, this message translates to:
  /// **'Food'**
  String get add_product_category_food;

  /// No description provided for @add_product_description_label.
  ///
  /// In en, this message translates to:
  /// **'DESCRIPTION'**
  String get add_product_description_label;

  /// No description provided for @add_product_description_hint.
  ///
  /// In en, this message translates to:
  /// **'E.g.: With french fries, house sauce, and daily side'**
  String get add_product_description_hint;

  /// No description provided for @add_product_active_label.
  ///
  /// In en, this message translates to:
  /// **'Active product'**
  String get add_product_active_label;

  /// No description provided for @add_product_cancel_button.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get add_product_cancel_button;

  /// No description provided for @add_product_submit_button.
  ///
  /// In en, this message translates to:
  /// **'Create Product'**
  String get add_product_submit_button;

  /// No description provided for @message_product_added.
  ///
  /// In en, this message translates to:
  /// **'Product Added Successfully'**
  String get message_product_added;

  /// No description provided for @no_description.
  ///
  /// In en, this message translates to:
  /// **'No description'**
  String get no_description;

  /// No description provided for @message_save_changes.
  ///
  /// In en, this message translates to:
  /// **'Save Changes'**
  String get message_save_changes;

  /// No description provided for @edit_product.
  ///
  /// In en, this message translates to:
  /// **'Edit Product'**
  String get edit_product;

  /// No description provided for @message_product_updated.
  ///
  /// In en, this message translates to:
  /// **'Product Updated Successfully'**
  String get message_product_updated;

  /// No description provided for @message_product_deleted.
  ///
  /// In en, this message translates to:
  /// **'Product Deleted Successfully'**
  String get message_product_deleted;

  /// No description provided for @delete_action.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete_action;

  /// No description provided for @delete_product_dialog_title.
  ///
  /// In en, this message translates to:
  /// **'Delete Product'**
  String get delete_product_dialog_title;

  /// No description provided for @delete_product_dialog_message.
  ///
  /// In en, this message translates to:
  /// **'Delete this product? This action cannot be undone.'**
  String get delete_product_dialog_message;

  /// No description provided for @table_management.
  ///
  /// In en, this message translates to:
  /// **'Table Maganement'**
  String get table_management;

  /// No description provided for @table_management_description.
  ///
  /// In en, this message translates to:
  /// **'Manage your tables, dining areas, and the status of each one.'**
  String get table_management_description;

  /// No description provided for @table_management_tables_tab.
  ///
  /// In en, this message translates to:
  /// **'Table Management'**
  String get table_management_tables_tab;

  /// No description provided for @table_management_salons_tab.
  ///
  /// In en, this message translates to:
  /// **'Dining Areas'**
  String get table_management_salons_tab;

  /// No description provided for @table_management_status_available.
  ///
  /// In en, this message translates to:
  /// **'Available'**
  String get table_management_status_available;

  /// No description provided for @table_management_status_occupied.
  ///
  /// In en, this message translates to:
  /// **'Occupied'**
  String get table_management_status_occupied;

  /// No description provided for @table_management_new_table.
  ///
  /// In en, this message translates to:
  /// **'New Table'**
  String get table_management_new_table;

  /// No description provided for @table_management_new_salon.
  ///
  /// In en, this message translates to:
  /// **'New Dining Area'**
  String get table_management_new_salon;

  /// No description provided for @table_management_new_salon_description.
  ///
  /// In en, this message translates to:
  /// **'Add a dining area to the restaurant'**
  String get table_management_new_salon_description;

  /// No description provided for @table_management_all_salons.
  ///
  /// In en, this message translates to:
  /// **'All Dining Areas'**
  String get table_management_all_salons;

  /// No description provided for @table_management_salon_main.
  ///
  /// In en, this message translates to:
  /// **'Main Dining Room'**
  String get table_management_salon_main;

  /// No description provided for @table_management_salon_vip.
  ///
  /// In en, this message translates to:
  /// **'VIP Dining Room'**
  String get table_management_salon_vip;

  /// No description provided for @table_management_salon_terrace.
  ///
  /// In en, this message translates to:
  /// **'Terrace'**
  String get table_management_salon_terrace;

  /// No description provided for @table_management_tables_count.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{# table} other{# tables}}'**
  String table_management_tables_count(int count);

  /// No description provided for @table_management_available_count.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{# available} other{# available}}'**
  String table_management_available_count(int count);

  /// No description provided for @table_management_people_count.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{# person} other{# people}}'**
  String table_management_people_count(int count);

  /// No description provided for @table_management_table_name.
  ///
  /// In en, this message translates to:
  /// **'Table {number}'**
  String table_management_table_name(int number);

  /// No description provided for @table_management_salon_summary.
  ///
  /// In en, this message translates to:
  /// **'{totalTables, plural, =1{# table} other{# tables}} · {occupiedTables, plural, =1{# occupied} other{# occupied}}'**
  String table_management_salon_summary(int totalTables, int occupiedTables);
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'es'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'es': return AppLocalizationsEs();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
