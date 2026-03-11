// final sl = GetIt.instance;

Future<void> initInjector() async {
  // External
  // sl.registerLazySingleton<http.Client>(() => http.Client());

  // ** Data Sources **

  //example
  // sl.registerLazySingleton<SubmissionsRemoteDataSource>(
  //   () => SubmissionsRemoteDataSourceImpl(
  //     client: sl<http.Client>(),
  //     firebaseAuth: di<fb.FirebaseAuth>(),
  //   ),
  // );

  // ** Repositories **

  // Example
  // sl.registerLazySingleton<ActivitiesRepository>(
  //   () => ActivitiesRepositoryImpl(remote: sl()),
  // );

  // ** Use Cases **

  // Example
  // sl.registerLazySingleton<GetUserReviewsUseCase>(
  //   () => GetUserReviewsUseCase(userReviewRepository: sl()),
  // );

  // ** BLoCs **

  // Example
  // sl.registerLazySingleton<ActivitiesBloc>(
  //   () => ActivitiesBloc(
  //     getPaginatedActivities: sl(),
  //     addActivity: sl(),
  //     getActivityDetails: sl(),
  //     checkActivityDuplicate: sl(),
  //     updateActivityUseCase: sl(),
  //   ),
  // );
}
