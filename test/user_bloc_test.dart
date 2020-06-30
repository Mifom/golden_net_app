import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_net_app/core/failure.dart';
import 'package:golden_net_app/domain/bloc/user/user_bloc.dart';
import 'package:golden_net_app/domain/enteties/user.dart';
import 'package:golden_net_app/domain/repositories/user_repository.dart';
import 'package:mockito/mockito.dart';

class MockUserRepository extends Mock implements UserRepository {}

main() {
  MockUserRepository repository;
  setUp(() {
    repository = MockUserRepository();
  });

  final tUser = User(email: "test@test.com", password: "test");

  final tFailure = BasicFailure("No internet");
  group("test UserBloc", () {
    blocTest("test UserLogIn good result",
      build: () async {
        when(repository.logIn(tUser.email, tUser.password)).thenAnswer((realInvocation) async => Right(tUser));
        return UserBloc(repository);
      },
      act: (bloc) async => bloc.add(UserLogIn(email: tUser.email, password: tUser.password)),
      expect: [
        UserLogedIn(user: tUser)
      ]
    );
    blocTest("test UserLogIn bad result",
      build: () async {
        when(repository.logIn(any, any)).thenAnswer((realInvocation) async =>Left(tFailure));
        return UserBloc(repository);
      },
      act: (bloc) async => bloc.add(UserLogIn(email: tUser.email, password: tUser.password)),
      expect: [
        UserFailedLogIn(message: tFailure.toString())
      ]
    );
    blocTest("test UserSignUp good result",
      build: () async {
        when(repository.newUser(tUser.email, tUser.password)).thenAnswer((realInvocation) async =>Right(tUser));
        return UserBloc(repository);
      },
      act: (bloc) async => bloc.add(UserSignUp(email: tUser.email, password: tUser.password)),
      expect: [
        UserLogedIn(user: tUser)
      ]
    );
    blocTest("test UserSignUp bad result",
      build: () async {
        when(repository.newUser(any, any)).thenAnswer((realInvocation) async =>Left(tFailure));
        return UserBloc(repository);
      },
      act: (bloc) async => bloc.add(UserSignUp(email: tUser.email, password: tUser.password)),
      expect: [
        UserFailedSignUp(message: tFailure.toString())
      ]
    );
  });
}