import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/helper/convert/input_converter.dart';
import 'core/network/network_info.dart';
import 'features/product/data/datasources/local_data_sources.dart';
import 'features/product/data/datasources/remote_data_sources.dart';
import 'features/product/data/repositories/product_repository_impl.dart';
import 'features/product/domain/repositories/product_repository.dart';

import 'features/product/domain/usecases/delete_product_usescase.dart';
import 'features/product/domain/usecases/get_all_product_usecase.dart';
import 'features/product/domain/usecases/get_product_usescase.dart';
import 'features/product/domain/usecases/insert_product_usecase.dart';
import 'features/product/domain/usecases/update_product_usecase.dart';
import 'features/product/presentation/bloc/product_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Features
  sl.registerFactory(
    () => ProductBloc(
      sl(),
      sl(),
      sl(),
      sl(),
      sl(),
    ),
  );

  // use case
  sl.registerFactory(() => GetAllProductUsecase(sl()));
  sl.registerFactory(() => DeleteProductUsecase(sl()));
  sl.registerFactory(() => GetProductUsecase(sl()));
  sl.registerFactory(() => CreateProductUsecase(sl()));
  sl.registerFactory(() => UpdateProductUsecase(sl()));

  // Repository

  sl.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<ProductRemoteDataSource>(
      () => ProductRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<ProductLocalDataSource>(
    () => ProductLocalDataSourceImpl(sl()),
  );
  // Core
  sl.registerLazySingleton(() => InputConverter());
  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(sl()),
  );

  //  External
  final sharedpreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedpreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
