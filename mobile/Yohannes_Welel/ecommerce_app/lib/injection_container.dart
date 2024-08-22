import 'package:get_it/get_it.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/network/network_info.dart';
import 'features/product/data/data_sources/local/local_data_source.dart';
import 'features/product/data/data_sources/local/local_data_source_impl.dart';
import 'features/product/data/data_sources/local/user_local_data_sources.dart';
import 'features/product/data/data_sources/remote/remote_data_source.dart';
import 'features/product/data/data_sources/remote/remote_data_source_impl.dart';
import 'features/product/data/data_sources/remote/user_remote_data_source.dart';
import 'features/product/data/repositories/product_repository_impl.dart';
import 'features/product/data/repositories/user_repository_impl.dart';
import 'features/product/domain/repository/product_repository.dart';
import 'features/product/domain/repository/user_repository.dart';
import 'features/product/domain/usecases/add_product_usecase.dart';
import 'features/product/domain/usecases/delete_product_usecase.dart';
import 'features/product/domain/usecases/get_product_usecase.dart';
import 'features/product/domain/usecases/get_products_usecase.dart';
import 'features/product/domain/usecases/update_product_usecase.dart';
import 'features/product/domain/usecases/user/get_user_case.dart';
import 'features/product/domain/usecases/user/login_usecase.dart';
import 'features/product/domain/usecases/user/register_usecase.dart';
import 'features/product/presentation/blocs/product/product_bloc.dart';
import 'features/product/presentation/blocs/user/bloc/user_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Product feature
  // Bloc
    final sharedPreferences = await SharedPreferences.getInstance();
sl.registerLazySingleton(() => sharedPreferences);
  sl.registerFactory(
    () => ProductBloc(
      addProductUsecase: sl(),
      updateProductUsecase: sl(),
      deleteProductUsecase: sl(),
      getProductUsecase: sl(),
      getProductsUsecase: sl(),
    ),
  );
  // Use cases
  sl.registerLazySingleton(() => AddProductUsecase(sl()));
  sl.registerLazySingleton(() => GetProductUsecase(sl()));
  sl.registerLazySingleton(() => GetProductsUsecase(sl()));
  sl.registerLazySingleton(() => UpdateProductUsecase(sl()));
  sl.registerLazySingleton(() => DeleteProductUsecase(sl()));
  

sl.registerLazySingleton<UserLocalDataSource>(
  () => UserLocalDataSourceImpl(sharedPreferences: sl()),
);

  sl.registerLazySingleton<UserRemoteDataSource>(
    () => UserRemoteDataSourceImpl(client: sl()),
  );
  // Repository
  sl.registerLazySingleton<ProductRepository>(() => ProductRepositoryImpl(
        remoteDataSource: sl(),
        localDataSource: sl(),
        networkInfo: sl(),
      ));
  // Data sources
  sl.registerLazySingleton<ProductRemoteDataSource>(
    () => RemoteDataSourceImpl(client: sl(), userLocalDataSource: sl()),
  );
  sl.registerLazySingleton<ProductLocalDataSource>(
    () => ProductLocalDataSourceImpl(sharedPreferences: sl()),
  );

  // User feature
  // Bloc
  sl.registerFactory(
    () => UserBloc(
      login: sl<Login>(),
      register: sl<Register>(),
      getUser: sl<GetUser>(),
    ),
  );



  // Use cases

  sl.registerLazySingleton(() => Login(sl()));
  sl.registerLazySingleton(() => Register(sl<UserRepository>()));
  sl.registerLazySingleton(() => GetUser(sl<UserRepository>()));
  // Repository
  sl.registerLazySingleton<UserRepository>(() => UserRepositoryImpl(
        localDataSource: sl<UserLocalDataSource>(),
        remoteDataSource: sl<UserRemoteDataSource>(),
        networkInfo: sl<NetworkInfo>(),
      ));



  // Core
  sl.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(internetConnectionChecker: sl()));

  // External
  // final sharedPreferences = await SharedPreferences.getInstance();
  const secureStorage = FlutterSecureStorage();

  sl.registerLazySingleton(() => secureStorage);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
