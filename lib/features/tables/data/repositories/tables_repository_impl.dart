

// class UserReviewRepositoryImpl implements UserReviewRepository {
//   final UserReviewRemoteDataSource remoteDataSource;

//   UserReviewRepositoryImpl({required this.remoteDataSource});

//   @override
//   Future<PaginatedResponse<UserReviewEntity>> getUserReviews({
//     int page = 1,
//     int pageSize = 100,
//     String? search,
//     Map<String, dynamic>? filters,
//   }) async {
//     final userReviewModels = await remoteDataSource.getUserReviews(
//       page: page,
//       pageSize: pageSize,
//       search: search,
//       filters: filters,
//     );

//     final mappedItems = userReviewModels.items
//         .map((model) => UserReviewMapper.toEntity(model))
//         .toList(growable: false);

//     return PaginatedResponse<UserReviewEntity>(
//       items: mappedItems,
//       pageInfo: userReviewModels.pageInfo,
//       filters: userReviewModels.filters,
//       detectedItemsKey: userReviewModels.detectedItemsKey,
//     );
//   }

//   @override
//   Future<bool> approveUserReview({
//     required int reviewId,
//     required String reviewType,
//   }) async {
//     return remoteDataSource.approveUserReview(
//       reviewId: reviewId,
//       reviewType: reviewType,
//     );
//   }

//   @override
//   Future<bool> rejectUserReview({
//     required int reviewId,
//     required String reviewType,
//   }) async {
//     return remoteDataSource.rejectUserReview(
//       reviewId: reviewId,
//       reviewType: reviewType,
//     );
//   }
// }
