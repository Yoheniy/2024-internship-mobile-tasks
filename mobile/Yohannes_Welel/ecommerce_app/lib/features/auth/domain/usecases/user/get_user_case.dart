import 'package:dartz/dartz.dart';

import '../../../../../core/error/failure.dart';
import '../../entity/user.dart';
import '../../repository/user_repository.dart';


class GetUser {
  final UserRepository _repository;

  GetUser(this._repository);

  Future<Either<Failure, UserEntity>> call(String accessToken) async {
    return await _repository.getUser(accessToken);
  }
}