// user_state.dart
import 'package:equatable/equatable.dart';

import '../../../domain/entity/user.dart';

abstract class UserState extends Equatable {
  @override
  List<Object?> get props => [];
}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserLoaded extends UserState {
  final UserEntity user;

  UserLoaded(this.user);

  @override
  List<Object?> get props => [user];
}

class UserLoginSuccess extends UserState {
  final String accessToken;

  UserLoginSuccess(this.accessToken);

  @override
  List<Object?> get props => [accessToken];
}

class UserError extends UserState {
  final String message;

  UserError(this.message);

  @override
  List<Object?> get props => [message];
}

class UserLoggedOut extends UserState {}