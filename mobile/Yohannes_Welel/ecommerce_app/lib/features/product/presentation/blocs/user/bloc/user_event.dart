// user_event.dart
import 'package:equatable/equatable.dart';

abstract class UserEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class UserLoginRequested extends UserEvent {
  final String email;
  final String password;

  UserLoginRequested(this.email, this.password);

  @override
  List<Object?> get props => [email, password];
}

class UserRegisterRequested extends UserEvent {
  final String name;
  final String email;
  final String password;

  UserRegisterRequested(this.name, this.email, this.password);

  @override
  List<Object?> get props => [name, email, password];
}

class UserGetRequested extends UserEvent {
  final String accessToken;

  UserGetRequested(this.accessToken);

  @override
  List<Object?> get props => [accessToken];
}