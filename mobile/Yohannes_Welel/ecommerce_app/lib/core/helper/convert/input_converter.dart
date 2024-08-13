import 'package:dartz/dartz.dart';

import '../../errormessage/failure.dart';


class InputConverter {
  Either<Failure, double> stringToUnsignedDouble(String str) {
    try {
      final val = double.parse(str);
      if (val < 0) throw const FormatException();
      return Right(val);
    } on FormatException {
      return const Left(
        InvalidInputFailure(),
      );
    }
  }
}

class InvalidInputFailure extends Failure {
  const InvalidInputFailure() : super('Invalid Input');
}