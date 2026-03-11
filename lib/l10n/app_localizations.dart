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
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

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
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es'),
  ];

  /// Application title displayed in window titles and SEO metadata.
  ///
  /// In en, this message translates to:
  /// **'Good For Your Brain Admin'**
  String get appTitle;

  /// No description provided for @edit_product_text.
  ///
  /// In en, this message translates to:
  /// **'Edit Product'**
  String get edit_product_text;

  /// No description provided for @edit_activity.
  ///
  /// In en, this message translates to:
  /// **'Edit Activity'**
  String get edit_activity;

  /// No description provided for @helloWorld.
  ///
  /// In en, this message translates to:
  /// **'Hello World!'**
  String get helloWorld;

  /// No description provided for @approve.
  ///
  /// In en, this message translates to:
  /// **'Approve'**
  String get approve;

  /// No description provided for @reject.
  ///
  /// In en, this message translates to:
  /// **'Reject'**
  String get reject;

  /// No description provided for @approved.
  ///
  /// In en, this message translates to:
  /// **'Approved'**
  String get approved;

  /// No description provided for @rejected.
  ///
  /// In en, this message translates to:
  /// **'Rejected'**
  String get rejected;

  /// No description provided for @pending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get pending;

  /// No description provided for @type_text.
  ///
  /// In en, this message translates to:
  /// **'Type:'**
  String get type_text;

  /// No description provided for @type.
  ///
  /// In en, this message translates to:
  /// **'Type'**
  String get type;

  /// No description provided for @category_text.
  ///
  /// In en, this message translates to:
  /// **'Category:'**
  String get category_text;

  /// No description provided for @category.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get category;

  /// No description provided for @barcode_text.
  ///
  /// In en, this message translates to:
  /// **'Barcode:'**
  String get barcode_text;

  /// No description provided for @barcode.
  ///
  /// In en, this message translates to:
  /// **'Barcode'**
  String get barcode;

  /// No description provided for @enter_barcode.
  ///
  /// In en, this message translates to:
  /// **'Barcode here'**
  String get enter_barcode;

  /// No description provided for @brand.
  ///
  /// In en, this message translates to:
  /// **'Brand'**
  String get brand;

  /// No description provided for @brand_text.
  ///
  /// In en, this message translates to:
  /// **'Brand:'**
  String get brand_text;

  /// No description provided for @ingredients_text.
  ///
  /// In en, this message translates to:
  /// **'Ingredients:'**
  String get ingredients_text;

  /// No description provided for @ingredients.
  ///
  /// In en, this message translates to:
  /// **'Ingredients'**
  String get ingredients;

  /// No description provided for @product_name_text.
  ///
  /// In en, this message translates to:
  /// **'Product Name:'**
  String get product_name_text;

  /// No description provided for @submitted_by_text.
  ///
  /// In en, this message translates to:
  /// **'Submitted by:'**
  String get submitted_by_text;

  /// No description provided for @submitted_by.
  ///
  /// In en, this message translates to:
  /// **'Submitted by'**
  String get submitted_by;

  /// No description provided for @submitted_on_text.
  ///
  /// In en, this message translates to:
  /// **'Submitted on:'**
  String get submitted_on_text;

  /// No description provided for @submitted_on.
  ///
  /// In en, this message translates to:
  /// **'Submitted on'**
  String get submitted_on;

  /// No description provided for @rating_text.
  ///
  /// In en, this message translates to:
  /// **'Rating:'**
  String get rating_text;

  /// No description provided for @rating.
  ///
  /// In en, this message translates to:
  /// **'Rating'**
  String get rating;

  /// No description provided for @ai_suggested_rating_text.
  ///
  /// In en, this message translates to:
  /// **'AI Suggested Rating:'**
  String get ai_suggested_rating_text;

  /// No description provided for @ai_suggested_rating.
  ///
  /// In en, this message translates to:
  /// **'AI Suggested Rating'**
  String get ai_suggested_rating;

  /// No description provided for @amen_approved_text.
  ///
  /// In en, this message translates to:
  /// **'Amen Approved:'**
  String get amen_approved_text;

  /// No description provided for @advice_text.
  ///
  /// In en, this message translates to:
  /// **'Advice:'**
  String get advice_text;

  /// No description provided for @flag_count_text.
  ///
  /// In en, this message translates to:
  /// **'Flag Count:'**
  String get flag_count_text;

  /// No description provided for @flag_count.
  ///
  /// In en, this message translates to:
  /// **'Flag Count'**
  String get flag_count;

  /// No description provided for @review_status_text.
  ///
  /// In en, this message translates to:
  /// **'Review Status:'**
  String get review_status_text;

  /// No description provided for @review_status.
  ///
  /// In en, this message translates to:
  /// **'Review Status'**
  String get review_status;

  /// No description provided for @last_updated_text.
  ///
  /// In en, this message translates to:
  /// **'Last Updated:'**
  String get last_updated_text;

  /// No description provided for @last_updated.
  ///
  /// In en, this message translates to:
  /// **'Last Updated'**
  String get last_updated;

  /// No description provided for @reviewed_by_text.
  ///
  /// In en, this message translates to:
  /// **'Reviewed by:'**
  String get reviewed_by_text;

  /// No description provided for @history_log_text.
  ///
  /// In en, this message translates to:
  /// **'History Log:'**
  String get history_log_text;

  /// No description provided for @history_log_label.
  ///
  /// In en, this message translates to:
  /// **'History Log'**
  String get history_log_label;

  /// No description provided for @id_text.
  ///
  /// In en, this message translates to:
  /// **'ID'**
  String get id_text;

  /// No description provided for @name_text.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name_text;

  /// No description provided for @image_text.
  ///
  /// In en, this message translates to:
  /// **'Image'**
  String get image_text;

  /// No description provided for @status_text.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get status_text;

  /// No description provided for @bfl_rating_text.
  ///
  /// In en, this message translates to:
  /// **'BFL Rating'**
  String get bfl_rating_text;

  /// No description provided for @ai_rating_text.
  ///
  /// In en, this message translates to:
  /// **'AI Rating'**
  String get ai_rating_text;

  /// No description provided for @user_rating_text.
  ///
  /// In en, this message translates to:
  /// **'User Rating'**
  String get user_rating_text;

  /// No description provided for @rating_score_text.
  ///
  /// In en, this message translates to:
  /// **'Rating Score'**
  String get rating_score_text;

  /// No description provided for @avg_user_rating_text.
  ///
  /// In en, this message translates to:
  /// **'Avg User Rating'**
  String get avg_user_rating_text;

  /// No description provided for @disagreement_text.
  ///
  /// In en, this message translates to:
  /// **'% Disagreement'**
  String get disagreement_text;

  /// No description provided for @number_of_reviews_text.
  ///
  /// In en, this message translates to:
  /// **'Number of Reviews'**
  String get number_of_reviews_text;

  /// No description provided for @number_of_scans_text.
  ///
  /// In en, this message translates to:
  /// **'Number of Scans'**
  String get number_of_scans_text;

  /// No description provided for @similar_ids_text.
  ///
  /// In en, this message translates to:
  /// **'Similar IDs'**
  String get similar_ids_text;

  /// No description provided for @last_updated_by_text.
  ///
  /// In en, this message translates to:
  /// **'Last Updated By'**
  String get last_updated_by_text;

  /// No description provided for @number_of_times_logged_text.
  ///
  /// In en, this message translates to:
  /// **'Number of times logged'**
  String get number_of_times_logged_text;

  /// No description provided for @admin_notes_text.
  ///
  /// In en, this message translates to:
  /// **'Admin Notes'**
  String get admin_notes_text;

  /// No description provided for @version_text.
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get version_text;

  /// No description provided for @no_data_available_text.
  ///
  /// In en, this message translates to:
  /// **'No data available'**
  String get no_data_available_text;

  /// No description provided for @step_text.
  ///
  /// In en, this message translates to:
  /// **'Step'**
  String get step_text;

  /// No description provided for @cancel_text.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel_text;

  /// No description provided for @next_text.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next_text;

  /// No description provided for @adding_text.
  ///
  /// In en, this message translates to:
  /// **'Adding'**
  String get adding_text;

  /// No description provided for @done_text.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get done_text;

  /// No description provided for @select_text.
  ///
  /// In en, this message translates to:
  /// **'Select'**
  String get select_text;

  /// No description provided for @category_hint_text.
  ///
  /// In en, this message translates to:
  /// **'Select your category'**
  String get category_hint_text;

  /// No description provided for @add_icon_text.
  ///
  /// In en, this message translates to:
  /// **'Add Icon'**
  String get add_icon_text;

  /// No description provided for @write_your_advice_text.
  ///
  /// In en, this message translates to:
  /// **'Write your advice here'**
  String get write_your_advice_text;

  /// No description provided for @notes_text.
  ///
  /// In en, this message translates to:
  /// **'Notes'**
  String get notes_text;

  /// No description provided for @write_notes_text.
  ///
  /// In en, this message translates to:
  /// **'Write your notes here'**
  String get write_notes_text;

  /// No description provided for @no_matches_found_text.
  ///
  /// In en, this message translates to:
  /// **'No matches found'**
  String get no_matches_found_text;

  /// No description provided for @try_refining_your_search_text.
  ///
  /// In en, this message translates to:
  /// **'Try refining your search'**
  String get try_refining_your_search_text;

  /// No description provided for @search_text.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search_text;

  /// No description provided for @activity_add_text.
  ///
  /// In en, this message translates to:
  /// **'Add Activity'**
  String get activity_add_text;

  /// No description provided for @activity_add_new_text.
  ///
  /// In en, this message translates to:
  /// **'Add new'**
  String get activity_add_new_text;

  /// No description provided for @activity_submit_success_text.
  ///
  /// In en, this message translates to:
  /// **'Activity submitted successfully'**
  String get activity_submit_success_text;

  /// No description provided for @activity_name_text.
  ///
  /// In en, this message translates to:
  /// **'Activity Name'**
  String get activity_name_text;

  /// No description provided for @activity_name_hint_text.
  ///
  /// In en, this message translates to:
  /// **'Activity name here'**
  String get activity_name_hint_text;

  /// No description provided for @submitted_on_success.
  ///
  /// In en, this message translates to:
  /// **'Product submitted successfully'**
  String get submitted_on_success;

  /// No description provided for @filter_by_text.
  ///
  /// In en, this message translates to:
  /// **'Filter by:'**
  String get filter_by_text;

  /// No description provided for @add_filter_text.
  ///
  /// In en, this message translates to:
  /// **'Add filter'**
  String get add_filter_text;

  /// No description provided for @add_filters_text.
  ///
  /// In en, this message translates to:
  /// **'Add filters'**
  String get add_filters_text;

  /// No description provided for @apply_text.
  ///
  /// In en, this message translates to:
  /// **'Apply'**
  String get apply_text;

  /// No description provided for @all_text.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get all_text;

  /// No description provided for @user_disagreement_text.
  ///
  /// In en, this message translates to:
  /// **'User Disagreement'**
  String get user_disagreement_text;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @product_name.
  ///
  /// In en, this message translates to:
  /// **'Product Name'**
  String get product_name;

  /// No description provided for @activity_name.
  ///
  /// In en, this message translates to:
  /// **'Activity Name'**
  String get activity_name;

  /// No description provided for @enter_activity_name.
  ///
  /// In en, this message translates to:
  /// **'Activity name here'**
  String get enter_activity_name;

  /// No description provided for @add_icon.
  ///
  /// In en, this message translates to:
  /// **'Add Icon'**
  String get add_icon;

  /// No description provided for @front_of_package.
  ///
  /// In en, this message translates to:
  /// **'Front of package'**
  String get front_of_package;

  /// No description provided for @back_of_package.
  ///
  /// In en, this message translates to:
  /// **'Back of package (w/ ingredients)'**
  String get back_of_package;

  /// No description provided for @select_category.
  ///
  /// In en, this message translates to:
  /// **'Select your category'**
  String get select_category;

  /// No description provided for @enter_product_name.
  ///
  /// In en, this message translates to:
  /// **'Product name here'**
  String get enter_product_name;

  /// No description provided for @brand_name.
  ///
  /// In en, this message translates to:
  /// **'Brand Name'**
  String get brand_name;

  /// No description provided for @enter_brand_name.
  ///
  /// In en, this message translates to:
  /// **'Brand name here'**
  String get enter_brand_name;

  /// No description provided for @enter_product_type.
  ///
  /// In en, this message translates to:
  /// **'Enter product type'**
  String get enter_product_type;

  /// No description provided for @add_new_product.
  ///
  /// In en, this message translates to:
  /// **'Add new product'**
  String get add_new_product;

  /// No description provided for @submit_product.
  ///
  /// In en, this message translates to:
  /// **'Submit Product'**
  String get submit_product;

  /// No description provided for @product_saved_successfully.
  ///
  /// In en, this message translates to:
  /// **'Product saved successfully'**
  String get product_saved_successfully;

  /// No description provided for @product_updated.
  ///
  /// In en, this message translates to:
  /// **'Product information updated successfully'**
  String get product_updated;

  /// No description provided for @activity_updated.
  ///
  /// In en, this message translates to:
  /// **'Activity updated successfully'**
  String get activity_updated;

  /// No description provided for @product_image_updated.
  ///
  /// In en, this message translates to:
  /// **'Product image updated successfully'**
  String get product_image_updated;

  /// No description provided for @product_status_updated.
  ///
  /// In en, this message translates to:
  /// **'Product status updated successfully'**
  String get product_status_updated;

  /// No description provided for @product_updated_tittle.
  ///
  /// In en, this message translates to:
  /// **'Product Updated'**
  String get product_updated_tittle;

  /// No description provided for @activity_updated_tittle.
  ///
  /// In en, this message translates to:
  /// **'Activity Updated'**
  String get activity_updated_tittle;

  /// No description provided for @activity_saved_successfully.
  ///
  /// In en, this message translates to:
  /// **'Activity saved successfully'**
  String get activity_saved_successfully;

  /// No description provided for @saving.
  ///
  /// In en, this message translates to:
  /// **'Saving...'**
  String get saving;

  /// No description provided for @bfl_rating.
  ///
  /// In en, this message translates to:
  /// **'BFL Rating'**
  String get bfl_rating;

  /// No description provided for @amen_approved.
  ///
  /// In en, this message translates to:
  /// **'Amen Approved'**
  String get amen_approved;

  /// No description provided for @advice.
  ///
  /// In en, this message translates to:
  /// **'Advice'**
  String get advice;

  /// No description provided for @enter_advice.
  ///
  /// In en, this message translates to:
  /// **'Write your advice here'**
  String get enter_advice;

  /// No description provided for @enter_bfl_advice.
  ///
  /// In en, this message translates to:
  /// **'Write your BFL advice here'**
  String get enter_bfl_advice;

  /// No description provided for @not_approved.
  ///
  /// In en, this message translates to:
  /// **'Not Approved'**
  String get not_approved;

  /// No description provided for @step.
  ///
  /// In en, this message translates to:
  /// **'step'**
  String get step;

  /// Admin notes for activity submission status.
  ///
  /// In en, this message translates to:
  /// **'The current status of this activity submission is {status}.'**
  String default_admin_notes(Object status);

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// No description provided for @publish.
  ///
  /// In en, this message translates to:
  /// **'Publish'**
  String get publish;

  /// No description provided for @product_or_activity_id.
  ///
  /// In en, this message translates to:
  /// **'Product or Activity ID'**
  String get product_or_activity_id;

  /// No description provided for @product_or_activity_name.
  ///
  /// In en, this message translates to:
  /// **'Product/Activity Name'**
  String get product_or_activity_name;

  /// No description provided for @user_name.
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get user_name;

  /// No description provided for @comment.
  ///
  /// In en, this message translates to:
  /// **'Comment'**
  String get comment;

  /// No description provided for @action.
  ///
  /// In en, this message translates to:
  /// **'Action'**
  String get action;

  /// No description provided for @ingredient_snippet.
  ///
  /// In en, this message translates to:
  /// **'Ingredient Snippet'**
  String get ingredient_snippet;

  /// No description provided for @product_images.
  ///
  /// In en, this message translates to:
  /// **'Product Images'**
  String get product_images;

  /// No description provided for @rows_per_page.
  ///
  /// In en, this message translates to:
  /// **'Rows per page:'**
  String get rows_per_page;

  /// No description provided for @export_cvs.
  ///
  /// In en, this message translates to:
  /// **'Export to CSV'**
  String get export_cvs;

  /// No description provided for @confirm_rejection.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to reject this submission?'**
  String get confirm_rejection;

  /// No description provided for @confirm_approval.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to approve this submission?'**
  String get confirm_approval;

  /// No description provided for @submission.
  ///
  /// In en, this message translates to:
  /// **'Submission'**
  String get submission;

  /// No description provided for @export_data_title.
  ///
  /// In en, this message translates to:
  /// **'Exporting data..'**
  String get export_data_title;

  /// No description provided for @export_data_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Please wait while we prepare your CSV export.'**
  String get export_data_subtitle;

  /// No description provided for @export_message.
  ///
  /// In en, this message translates to:
  /// **'The download will start automatically.'**
  String get export_message;

  /// No description provided for @user_review_title.
  ///
  /// In en, this message translates to:
  /// **'User review'**
  String get user_review_title;

  /// No description provided for @confirm_user_review_rejection.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to reject this user review?'**
  String get confirm_user_review_rejection;

  /// No description provided for @confirm_user_review_publish.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to publish this user review?'**
  String get confirm_user_review_publish;

  /// No description provided for @activity_duplicate_error.
  ///
  /// In en, this message translates to:
  /// **'An activity with this name already exists'**
  String get activity_duplicate_error;

  /// No description provided for @activity_duplicate_check_failed.
  ///
  /// In en, this message translates to:
  /// **'Failed to check for duplicate'**
  String get activity_duplicate_check_failed;

  /// No description provided for @activity_duplicate_check_error.
  ///
  /// In en, this message translates to:
  /// **'Error checking duplicate'**
  String get activity_duplicate_check_error;

  /// No description provided for @activiy_not_found_error.
  ///
  /// In en, this message translates to:
  /// **'Activity not found'**
  String get activiy_not_found_error;

  /// No description provided for @activity_details_text.
  ///
  /// In en, this message translates to:
  /// **'Activity Details'**
  String get activity_details_text;

  /// No description provided for @confirm_user_reviews_rejection.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to reject these user reviews?'**
  String get confirm_user_reviews_rejection;

  /// No description provided for @confirm_user_reviews_publish.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to publish these user reviews?'**
  String get confirm_user_reviews_publish;

  /// No description provided for @information.
  ///
  /// In en, this message translates to:
  /// **'Information'**
  String get information;

  /// No description provided for @reviews.
  ///
  /// In en, this message translates to:
  /// **'Reviews'**
  String get reviews;

  /// No description provided for @previous_activity.
  ///
  /// In en, this message translates to:
  /// **'Previous Activity'**
  String get previous_activity;

  /// No description provided for @next_activity.
  ///
  /// In en, this message translates to:
  /// **'Next Activity'**
  String get next_activity;

  /// No description provided for @product_info.
  ///
  /// In en, this message translates to:
  /// **'Product Info'**
  String get product_info;

  /// No description provided for @activity_info.
  ///
  /// In en, this message translates to:
  /// **'Activity Info'**
  String get activity_info;

  /// No description provided for @ratings.
  ///
  /// In en, this message translates to:
  /// **'Ratings'**
  String get ratings;

  /// No description provided for @score.
  ///
  /// In en, this message translates to:
  /// **'Score'**
  String get score;

  /// No description provided for @analytics.
  ///
  /// In en, this message translates to:
  /// **'Analytics'**
  String get analytics;

  /// No description provided for @bfl_advice.
  ///
  /// In en, this message translates to:
  /// **'BFL Advice'**
  String get bfl_advice;

  /// No description provided for @effect_on_brain.
  ///
  /// In en, this message translates to:
  /// **'Effects on the Brain'**
  String get effect_on_brain;

  /// No description provided for @summary.
  ///
  /// In en, this message translates to:
  /// **'Summary'**
  String get summary;

  /// No description provided for @good.
  ///
  /// In en, this message translates to:
  /// **'Good'**
  String get good;

  /// No description provided for @neutral.
  ///
  /// In en, this message translates to:
  /// **'Neutral'**
  String get neutral;

  /// No description provided for @bad.
  ///
  /// In en, this message translates to:
  /// **'Bad'**
  String get bad;

  /// No description provided for @total_reviews.
  ///
  /// In en, this message translates to:
  /// **'Total Reviews'**
  String get total_reviews;

  /// No description provided for @number_scans.
  ///
  /// In en, this message translates to:
  /// **'Number of Scans'**
  String get number_scans;

  /// No description provided for @number_searches.
  ///
  /// In en, this message translates to:
  /// **'Number of Searches'**
  String get number_searches;

  /// No description provided for @similar_ids.
  ///
  /// In en, this message translates to:
  /// **'Similar IDs'**
  String get similar_ids;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @previous_product.
  ///
  /// In en, this message translates to:
  /// **'Previous Product'**
  String get previous_product;

  /// No description provided for @next_product.
  ///
  /// In en, this message translates to:
  /// **'Next Product'**
  String get next_product;

  /// No description provided for @change_image.
  ///
  /// In en, this message translates to:
  /// **'Change Image'**
  String get change_image;

  /// No description provided for @remove_image.
  ///
  /// In en, this message translates to:
  /// **'Remove Image'**
  String get remove_image;

  /// No description provided for @save_changes.
  ///
  /// In en, this message translates to:
  /// **'Save Changes'**
  String get save_changes;

  /// No description provided for @score_summary.
  ///
  /// In en, this message translates to:
  /// **'Score Summary'**
  String get score_summary;

  /// No description provided for @enter_summary.
  ///
  /// In en, this message translates to:
  /// **'Write your summary here'**
  String get enter_summary;

  /// No description provided for @score_advice.
  ///
  /// In en, this message translates to:
  /// **'Score Advice'**
  String get score_advice;

  /// No description provided for @score_helper_text.
  ///
  /// In en, this message translates to:
  /// **'0-39 Bad   40-69 Neutral   70-100 Good'**
  String get score_helper_text;

  /// No description provided for @ingredients_helper_text.
  ///
  /// In en, this message translates to:
  /// **'(Separate by commas)'**
  String get ingredients_helper_text;

  /// No description provided for @provided_by.
  ///
  /// In en, this message translates to:
  /// **'Provided by'**
  String get provided_by;

  /// No description provided for @unknown_name.
  ///
  /// In en, this message translates to:
  /// **'Unknown Name'**
  String get unknown_name;

  /// No description provided for @unknown_brand.
  ///
  /// In en, this message translates to:
  /// **'Unknown Brand'**
  String get unknown_brand;

  /// No description provided for @unknown_category.
  ///
  /// In en, this message translates to:
  /// **'Unknown Category'**
  String get unknown_category;

  /// No description provided for @unknown_barcode.
  ///
  /// In en, this message translates to:
  /// **'Unknown Barcode'**
  String get unknown_barcode;

  /// No description provided for @not_entered.
  ///
  /// In en, this message translates to:
  /// **'Not Entered'**
  String get not_entered;

  /// No description provided for @no_effects_on_brain.
  ///
  /// In en, this message translates to:
  /// **'There are no effects on the brain available for this product.'**
  String get no_effects_on_brain;

  /// No description provided for @no_advice.
  ///
  /// In en, this message translates to:
  /// **'There is no advice available for this product.'**
  String get no_advice;

  /// No description provided for @no_bfl_advice.
  ///
  /// In en, this message translates to:
  /// **'There is no BFL advice available for this product.'**
  String get no_bfl_advice;

  /// No description provided for @no_summary.
  ///
  /// In en, this message translates to:
  /// **'There is no summary available for this product.'**
  String get no_summary;

  /// No description provided for @not_provided.
  ///
  /// In en, this message translates to:
  /// **'Not provided.'**
  String get not_provided;

  /// No description provided for @add_ingredients.
  ///
  /// In en, this message translates to:
  /// **'Add ingredients to see them here'**
  String get add_ingredients;

  /// No description provided for @type_ingredients.
  ///
  /// In en, this message translates to:
  /// **'Type to search ingredients'**
  String get type_ingredients;

  /// No description provided for @banner_missing_info.
  ///
  /// In en, this message translates to:
  /// **'Missing Info — Complete required details prior to approval.'**
  String get banner_missing_info;

  /// No description provided for @banner_filled_info.
  ///
  /// In en, this message translates to:
  /// **'Required fields are filled. Proceed with manual review before approving.'**
  String get banner_filled_info;

  /// No description provided for @enter_effect_on_brain.
  ///
  /// In en, this message translates to:
  /// **'Write the effects on the brain here'**
  String get enter_effect_on_brain;

  /// No description provided for @changing_image.
  ///
  /// In en, this message translates to:
  /// **'Changing...'**
  String get changing_image;

  /// No description provided for @removing_image.
  ///
  /// In en, this message translates to:
  /// **'Removing...'**
  String get removing_image;

  /// No description provided for @grade.
  ///
  /// In en, this message translates to:
  /// **'Grade'**
  String get grade;

  /// No description provided for @duplicated_product.
  ///
  /// In en, this message translates to:
  /// **'Duplicate product'**
  String get duplicated_product;

  /// No description provided for @open_existing_product.
  ///
  /// In en, this message translates to:
  /// **'Open existing product'**
  String get open_existing_product;

  /// No description provided for @change_status.
  ///
  /// In en, this message translates to:
  /// **'Change Status'**
  String get change_status;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'es'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
