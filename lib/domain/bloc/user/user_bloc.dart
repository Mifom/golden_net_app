import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:golden_net_app/domain/enteties/user.dart';
import 'package:golden_net_app/domain/repositories/user_repository.dart';
import 'package:meta/meta.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository _repository;

  UserBloc(this._repository);

  @override
  UserState get initialState => UserLogedOut();

  @override
  Stream<UserState> mapEventToState(
    UserEvent event,
  ) async* {
    if (event is UserLogOut) {
      yield UserLogedOut();
    } else if (event is UserLogIn) {
      yield UserUpdating();
      final either = await _repository.logIn(event.email, event.password);
      yield either.fold(
          (failure) => UserFailedLogIn(
              message: failure.toString()),
          (user) => UserLogedIn(user: user));
    } else if (event is UserSignUp) {
      yield UserUpdating();
      final either = await _repository
          .newUser(event.email, event.password);
      yield either.fold(
          (failure) => UserFailedSignUp(
              message: failure.toString()),
          (user) => UserLogedIn(user: user));
    }
  }
}
