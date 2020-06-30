part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();
}

class UserLogIn extends UserEvent {
  final String email;
  final String password;

  UserLogIn({
    @required this.email,
    @required this.password
  });

  @override
  List<Object> get props => [email, password];
}

class UserLogOut extends UserEvent {
  @override
  List<Object> get props => [];
}

class UserSignUp extends UserEvent {
  final String email;
  final String password;

  UserSignUp({
    @required this.email,
    @required this.password,
  });

  @override
  List<Object> get props => [email, password];
}