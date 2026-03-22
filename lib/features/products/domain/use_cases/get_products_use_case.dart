// import 'package:gfyb_admin_web/core/shared/data/models/paginated_response.dart';
// import 'package:gfyb_admin_web/features/user_reviews/domain/entities/user_review_entity.dart';
// import 'package:gfyb_admin_web/features/user_reviews/domain/repositories/user_review_repository.dart';

// class GetUserReviewsUseCase {
//   final UserReviewRepository userReviewRepository;

//   GetUserReviewsUseCase({required this.userReviewRepository});

//   Future<PaginatedResponse<UserReviewEntity>> call({
//     int page = 1,
//     int pageSize = 100,
//     String? search,
//     Map<String, dynamic>? filters,
//   }) {
//     return userReviewRepository.getUserReviews(
//       page: page,
//       pageSize: pageSize,
//       search: search,
//       filters: filters,
//     );
//   }
// }
