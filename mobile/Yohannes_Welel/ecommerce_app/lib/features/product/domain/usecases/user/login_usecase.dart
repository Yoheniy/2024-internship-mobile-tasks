import 'package:dartz/dartz.dart';

import '../../../../../core/error/failure.dart';
import '../../repository/user_repository.dart';



class Login {
  final UserRepository _userRepository;

  Login(this._userRepository);

  Future<Either<Failure, String>> call(String email, String password) async {
    return await _userRepository.login(email, password);
  }
}