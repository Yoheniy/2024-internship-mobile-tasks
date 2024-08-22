import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/user.dart';


abstract class UserRepository {
  Future<Either<Failure, String>> login(String email, String password);
  Future<Either<Failure, UserEntity>> register(String name, String email, String password);
  Future<Either<Failure, UserEntity>> getUser(String accessToken);
  Future<Either<Failure,bool>>logOut();
}