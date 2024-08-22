import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;

  const Failure(this.message);

  @override
  List<Object> get props => [message];

}
class ServerFailure extends Failure{
  const ServerFailure(super.message);
}
class CacheFailure extends Failure{
  const CacheFailure(super.message);
}
class ConnectionFailure extends Failure{
  const ConnectionFailure(super.message);
}

// general failure


// General failures
// class ServerFailure extends Failure {}

// class CacheFailure extends Failure {}

class NetworkFailure extends Failure {
   const NetworkFailure(super.message);
}

class ExceptionFailure extends Failure {
  const ExceptionFailure(super.message);
}

class CredentialFailure extends Failure {
   const CredentialFailure(super.message);
}

class AuthenticationFailure extends Failure {
  const AuthenticationFailure(super.message);
}
