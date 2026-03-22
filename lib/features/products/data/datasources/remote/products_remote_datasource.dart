// import 'dart:convert';

// import 'package:firebase_auth/firebase_auth.dart' as fb;
// import 'package:gfyb_admin_web/application/constants/user_reviews_api_endpoints.dart';
// import 'package:gfyb_admin_web/core/shared/data/models/paginated_response.dart';
// import 'package:gfyb_admin_web/core/utils/helpers/http_helper.dart';
// import 'package:gfyb_admin_web/features/user_reviews/data/models/user_review_model.dart';
// import 'package:http/http.dart' as http;

// abstract class UserReviewRemoteDataSource {
//   Future<PaginatedResponse<UserReviewModel>> getUserReviews({
//     required int page,
//     required int pageSize,
//     String? search,
//     Map<String, dynamic>? filters,
//   });
//   Future<bool> approveUserReview({
//     required int reviewId,
//     required String reviewType,
//   });
//   Future<bool> rejectUserReview({
//     required int reviewId,
//     required String reviewType,
//   });
// }

// class UserReviewRemoteDataSourceImpl implements UserReviewRemoteDataSource {
//   final http.Client _client;
//   final fb.FirebaseAuth _firebaseAuth;

//   UserReviewRemoteDataSourceImpl({
//     required http.Client client,
//     fb.FirebaseAuth? firebaseAuth,
//   }) : _client = client,
//        _firebaseAuth = firebaseAuth ?? fb.FirebaseAuth.instance;

//   @override
//   Future<PaginatedResponse<UserReviewModel>> getUserReviews({
//     required int page,
//     required int pageSize,
//     String? search,
//     Map<String, dynamic>? filters,
//   }) async {
//     try {
//       final uri = UserReviewsApiEndpoints.getUserReviews(
//         page: page,
//         pageSize: pageSize,
//         search: search,
//         filters: filters,
//       );

//       final headers = await HttpHelper.jsonHeaders(_firebaseAuth);
//       final response = await _client.get(uri, headers: headers);

//       if (response.statusCode < 200 || response.statusCode >= 300) {
//         throw Exception(
//           'Failed to load user reviews: HTTP ${response.statusCode}',
//         );
//       }

//       final decoded = json.decode(response.body);

//       if (decoded is! Map<String, dynamic>) {
//         throw const FormatException(
//           'Unexpected user reviews payload. Expected a JSON object.',
//         );
//       }
//       return PaginatedResponse<UserReviewModel>.fromJson(
//         decoded,
//         (json) => UserReviewModel.fromJson(json),
//         itemsKey: 'reviews',
//       );
//     } catch (e) {
//       throw Exception('Error getting user reviews: $e');
//     }
//   }

//   @override
//   Future<bool> approveUserReview({
//     required int reviewId,
//     required String reviewType,
//   }) async {
//     try {
//       // Prepare the request
//       final uri = UserReviewsApiEndpoints.approveUserReview();
//       final headers = await HttpHelper.jsonHeaders(_firebaseAuth);
//       final body = jsonEncode({
//         'review_type': reviewType,
//         'review_id': reviewId,
//       });

//       // Send the request
//       final response = await _client.put(uri, headers: headers, body: body);

//       // Check the response status
//       if (response.statusCode < 200 || response.statusCode >= 300) {
//         throw Exception(
//           'Failed to approve review $reviewId status: HTTP ${response.statusCode}',
//         );
//       }
//       return true;
//     } catch (e) {
//       throw Exception('Error approving review: $e');
//     }
//   }

//   @override
//   Future<bool> rejectUserReview({
//     required int reviewId,
//     required String reviewType,
//   }) async {
//     try {
//       // Prepare the request
//       final uri = UserReviewsApiEndpoints.rejectUserReview();
//       final headers = await HttpHelper.jsonHeaders(_firebaseAuth);
//       final body = jsonEncode({
//         'review_type': reviewType,
//         'review_id': reviewId,
//       });

//       // Send the request
//       final response = await _client.put(uri, headers: headers, body: body);

//       // Check the response status
//       if (response.statusCode < 200 || response.statusCode >= 300) {
//         throw Exception(
//           'Failed to reject review $reviewId status: HTTP ${response.statusCode}',
//         );
//       }
//       return true;
//     } catch (e) {
//       throw Exception('Error rejecting review: $e');
//     }
//   }
// }
