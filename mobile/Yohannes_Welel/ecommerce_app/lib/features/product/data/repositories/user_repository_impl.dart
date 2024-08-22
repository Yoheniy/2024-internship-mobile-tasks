import 'package:dartz/dartz.dart';



import '../../../../core/error/exception.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/user.dart';
import '../../domain/repository/user_repository.dart';
import '../data_sources/local/user_local_data_sources.dart';
import '../data_sources/remote/user_remote_data_source.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remoteDataSource;
  final UserLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  UserRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, String>> login(String email, String password) async {
    if (await networkInfo.isConnected) {
      try {
        final accessToken = await remoteDataSource.login(email, password);
        await localDataSource.cacheAccessToken(accessToken);
        return Right(accessToken);
      } catch (e) {
        return Left(ServerFailure(e.toString()));
      }
    } else {
      return Left(ConnectionFailure("No internet connection"));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> register(
      String name, String email, String password) async {
    if (await networkInfo.isConnected) {
      try {
        final user = await remoteDataSource.register(name, email, password);
        await localDataSource.cacheUser(user);
        return Right(user);
      } catch (e) {
        return Left(ServerFailure(e.toString()));
      }
    } else {
      return Left(ConnectionFailure("No internet connection"));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> getUser(String accessToken) async {
    try {
        final localUser = await localDataSource.getCachedUser();
      
      if (await networkInfo.isConnected) {
        try {
          final remoteUser = await remoteDataSource.getUser(accessToken);
          await localDataSource.cacheUser(remoteUser);
          return Right(remoteUser);
        } on ServerException {
          return Right(localUser); // Fallback to local data
        }
      } else {
      
        return Right(localUser);
      }
    } on CacheException {
      return Left(CacheFailure("No cached user"));
    }
  }
  
  @override
  Future<Either<Failure, bool>> logOut() {
    // TODO: implement logOut
    throw UnimplementedError();
  }
}

