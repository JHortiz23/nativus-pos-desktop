

// class UserReviewEntity extends Equatable {
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

//   const UserReviewEntity({
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

//   @override
//   List<Object?> get props => [
//     id,
//     reviewType,
//     productOrActivityId,
//     productOrActivityName,
//     userRating,
//     comment,
//     userName,
//     submittedOn,
//     reviewStatus,
//     lastUpdated,
//   ];

//   UserReviewEntity copyWith({
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
//     return UserReviewEntity(
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
// }
