

// class UserReviewModel {
//   final int id;
//   final String reviewType;
//   final int productOrActivityId;
//   final String productOrActivityName;
//   final String brand;
//   final String userRating;
//   final String comment;
//   final String userName;
//   final String submittedOn;
//   final String reviewStatus;
//   final String lastUpdated;

//   UserReviewModel({
//     required this.id,
//     required this.reviewType,
//     required this.productOrActivityId,
//     required this.productOrActivityName,
//     required this.brand,
//     required this.userRating,
//     required this.comment,
//     required this.userName,
//     required this.submittedOn,
//     required this.reviewStatus,
//     required this.lastUpdated,
//   });

//   factory UserReviewModel.fromJson(Map<String, dynamic> json) {
//     return UserReviewModel(
//       id: json['review_id'] ,
//       reviewType: json['review_type'] ?? '',
//       productOrActivityId: json['poa_id'] ?? '',
//       productOrActivityName: json['poa_name'] ?? '',
//       brand: json['brand'] ?? '',
//       userRating: json['user_rating'] ?? '',
//       comment: json['comment'] ?? '',
//       userName: json['username'] ?? '',
//       submittedOn: json['submitted_on'] ?? '',
//       reviewStatus: json['review_status'] ?? '',
//       lastUpdated: json['history_log'] ?? '',
//     );
//   }

//   UserReviewModel copyWith({
//     int? id,
//     String? reviewType,
//     int? productOrActivityId,
//     String? productOrActivityName,
//     String? brand,
//     String? userRating,
//     String? comment,
//     String? userName,
//     String? submittedOn,
//     String? reviewStatus,
//     String? lastUpdated,
//   }) {
//     return UserReviewModel(
//       id: id ?? this.id,
//       reviewType: reviewType ?? this.reviewType,
//       productOrActivityId: productOrActivityId ?? this.productOrActivityId,
//       productOrActivityName:
//           productOrActivityName ?? this.productOrActivityName,
//       brand: brand ?? this.brand,
//       userRating: userRating ?? this.userRating,
//       comment: comment ?? this.comment,
//       userName: userName ?? this.userName,
//       submittedOn: submittedOn ?? this.submittedOn,
//       reviewStatus: reviewStatus ?? this.reviewStatus,
//       lastUpdated: lastUpdated ?? this.lastUpdated,
//     );
//   }

//   factory UserReviewModel.fromEntity(UserReviewEntity entity) {
//     return UserReviewMapper.fromEntity(entity);
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'review_id': id,
//       'review_type': reviewType,
//       'poa_id': productOrActivityId,
//       'poa_name': productOrActivityName,
//       'brand': brand,
//       'user_rating': userRating,
//       'comment': comment,
//       'username': userName,
//       'submitted_on': submittedOn,
//       'review_status': reviewStatus,
//       'history_log': lastUpdated,
//     };
//   }
// }
