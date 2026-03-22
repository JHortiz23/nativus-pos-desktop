// import 'package:gfyb_admin_web/core/utils/helpers/formatters.dart';
// import 'package:gfyb_admin_web/features/user_reviews/data/models/user_review_model.dart';
// import 'package:gfyb_admin_web/features/user_reviews/domain/entities/user_review_entity.dart';
// import 'package:gfyb_admin_web/shared/utils/helpers/view/view_helpers.dart';

// class UserReviewMapper {
//   static UserReviewEntity toEntity(UserReviewModel model) {

//     return UserReviewEntity(
//       id: model.id,
//       reviewType: model.reviewType,
//       productOrActivityId: model.productOrActivityId,
//       productOrActivityName: model.productOrActivityName,
//       brand: model.brand,
//       userRating: model.userRating,
//       comment: model.comment,
//       userName: model.userName,
//       submittedOn: Formatters.formatDateString(model.submittedOn),
//       reviewStatus: capitalizeFirst(model.reviewStatus),
//       lastUpdated: Formatters.formatDateString(model.lastUpdated),
//     );
//   }

//   static UserReviewModel fromEntity(UserReviewEntity entity) {
//     return UserReviewModel(
//       id: entity.id,
//       reviewType: entity.reviewType,
//       productOrActivityId: entity.productOrActivityId,
//       productOrActivityName: entity.productOrActivityName,
//       brand: entity.brand,
//       userRating: entity.userRating,
//       comment: entity.comment,
//       userName: entity.userName,
//       submittedOn: entity.submittedOn,
//       reviewStatus: entity.reviewStatus,
//       lastUpdated: entity.lastUpdated,
//     );
//   }
// }
