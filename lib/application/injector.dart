import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:nativus_pos_desktop/core/utils/helpers/auth_token_storage.dart';
import 'package:nativus_pos_desktop/features/auth/data/datasources/local/auth_local_datasource.dart';
import 'package:nativus_pos_desktop/features/auth/data/datasources/remote/auth_remote_datasource.dart';
import 'package:nativus_pos_desktop/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:nativus_pos_desktop/features/auth/domain/repositories/auth_repository.dart';
import 'package:nativus_pos_desktop/features/auth/domain/use_cases/login_use_case.dart';
import 'package:nativus_pos_desktop/features/auth/presentation/cubit/login_cubit.dart';
import 'package:nativus_pos_desktop/features/products/data/datasources/remote/products_remote_datasource.dart';
import 'package:nativus_pos_desktop/features/products/data/repositories/products_repository_impl.dart';
import 'package:nativus_pos_desktop/features/products/domain/repositories/products_repository.dart';
import 'package:nativus_pos_desktop/features/products/domain/use_cases/product_use_cases.dart';
import 'package:nativus_pos_desktop/features/products/presentation/blocs/products_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> initInjector() async {
  final sharedPreferences = await SharedPreferences.getInstance();

  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
  sl.registerLazySingleton<http.Client>(() => http.Client());
  sl.registerLazySingleton<AuthTokenStorage>(
    () => AuthTokenStorage(preferences: sl<SharedPreferences>()),
  );
  // ** Data Sources **
  /// AUTHENTICATION
  sl.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceImpl(tokenStorage: sl<AuthTokenStorage>()),
  );

  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(client: sl<http.Client>()),
  );

  /// PRODUCTS
  sl.registerLazySingleton<ProductsRemoteDataSource>(
    () => ProductsRemoteDataSourceImpl(
      client: sl<http.Client>(),
      tokenStorage: sl<AuthTokenStorage>(),
    ),
  );

  // ** Repositories **
  /// AUTHENTICATION
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      remoteDataSource: sl<AuthRemoteDataSource>(),
      localDataSource: sl<AuthLocalDataSource>(),
    ),
  );

  /// PRODUCTS
  sl.registerLazySingleton<ProductsRepository>(
    () => ProductsRepositoryImpl(
      remoteDataSource: sl<ProductsRemoteDataSource>(),
    ),
  );

  // ** Use Cases **
  /// AUTHENTICATION
  sl.registerLazySingleton<LoginUseCase>(
    () => LoginUseCase(repository: sl<AuthRepository>()),
  );

  /// PRODUCTS
  sl.registerLazySingleton<AddProductUseCase>(
    () => AddProductUseCase(productsRepository: sl<ProductsRepository>()),
  );

  sl.registerLazySingleton<GetProductsUseCase>(
    () => GetProductsUseCase(productsRepository: sl<ProductsRepository>()),
  );

  sl.registerLazySingleton<GetProductCategoriesUseCase>(
    () => GetProductCategoriesUseCase(
      productsRepository: sl<ProductsRepository>(),
    ),
  );

  sl.registerLazySingleton<UpdateProductUseCase>(
    () => UpdateProductUseCase(productsRepository: sl<ProductsRepository>()),
  );

  // ** Cubits **
  /// AUTHENTICATION
  sl.registerFactory<LoginCubit>(
    () => LoginCubit(loginUseCase: sl<LoginUseCase>()),
  );

  // ** BLoCs **
  /// PRODUCTS
  sl.registerFactory<ProductsBloc>(
    () => ProductsBloc(
      addProductUseCase: sl(),
      getProductsUseCase: sl(),
      getProductCategoriesUseCase: sl(),
      updateProductUseCase: sl(),
    ),
  );
}
