import '../../../../../core/error/failure.dart';
import '../../entities/user.dart';
import 'package:dartz/dartz.dart';

import '../../repository/user_repository.dart';

class logOut{
  UserRepository userRepository;
  logOut(this.userRepository);

  @override
  Future<Either<Failure, bool>> call() async {
    return await userRepository.logOut(); 
  }

  
}