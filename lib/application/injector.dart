import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:nativus_pos_desktop/core/utils/helpers/auth_token_storage.dart';
import 'package:nativus_pos_desktop/features/auth/data/datasources/local/auth_local_datasource.dart';
import 'package:nativus_pos_desktop/features/auth/data/datasources/remote/auth_remote_datasource.dart';
import 'package:nativus_pos_desktop/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:nativus_pos_desktop/features/auth/domain/repositories/template_repository.dart';
import 'package:nativus_pos_desktop/features/auth/domain/use_cases/template_use_case.dart';
import 'package:nativus_pos_desktop/features/auth/presentation/cubit/login_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> initInjector() async {
  final sharedPreferences = await SharedPreferences.getInstance();

  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
  sl.registerLazySingleton<http.Client>(() => http.Client());
  sl.registerLazySingleton<AuthTokenStorage>(
    () => AuthTokenStorage(preferences: sl<SharedPreferences>()),
  );

  sl.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceImpl(tokenStorage: sl<AuthTokenStorage>()),
  );

  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(client: sl<http.Client>()),
  );

  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      remoteDataSource: sl<AuthRemoteDataSource>(),
      localDataSource: sl<AuthLocalDataSource>(),
    ),
  );

  sl.registerLazySingleton<LoginUseCase>(
    () => LoginUseCase(repository: sl<AuthRepository>()),
  );

  sl.registerFactory<LoginCubit>(
    () => LoginCubit(loginUseCase: sl<LoginUseCase>()),
  );

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
