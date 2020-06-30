part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  const UserState();
}

class UserLogedOut extends UserState {
  @override
  List<Object> get props => [];
}

class UserUpdating extends UserState {
  @override
  List<Object> get props => [];
}

class UserLogedIn extends UserState {
  final User user;

  UserLogedIn({@required this.user});

  @override
  List<Object> get props => [user];
}

class UserFailedLogIn extends UserState {
  final String message;

  UserFailedLogIn({@required this.message});

  @override
  List<Object> get props => [message];
}

class UserFailedSignUp extends UserState {
  final String message;

  UserFailedSignUp({@required this.message});

  @override
  List<Object> get props => [message];
}