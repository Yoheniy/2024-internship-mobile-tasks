// user_bloc.dart
import 'package:bloc/bloc.dart';

import '../../../../domain/usecases/user/get_user_case.dart';
import '../../../../domain/usecases/user/login_usecase.dart';
import '../../../../domain/usecases/user/register_usecase.dart';
import 'user_event.dart';
import 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final Login login;
  final Register register;
  final GetUser getUser;

  UserBloc({
    required this.login,
    required this.register,
    required this.getUser,
  }) : super(UserInitial()) {
    
    on<UserLoginRequested>((event, emit) async {
      emit(UserLoading());
      final failureOrSuccess = await login(
        event.email,
        event.password,
      );

      failureOrSuccess.fold(
        (failure) => emit(UserError('Invalid credentials')),
        (accessToken) => emit(UserLoginSuccess(accessToken)),
      );
    });

    on<UserRegisterRequested>((event, emit) async {
      emit(UserLoading());
      final failureOrSuccess =
          await register(event.name, event.email, event.password);

      failureOrSuccess.fold(
        (failure) => emit(UserError('Something went wrong')),
        (_) => emit(UserInitial()),
      );
    });

    on<UserGetRequested>((event, emit) async {
      emit(UserLoading());
      final failureOrUser = await getUser(event.accessToken);

      failureOrUser.fold(
        (failure) => emit(UserError(failure.message)),
        (user) => emit(UserLoaded(user)),
      );
    });
  }
}