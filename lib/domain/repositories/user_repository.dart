import 'package:dartz/dartz.dart';
import 'package:golden_net_app/core/failure.dart';
import 'package:golden_net_app/domain/enteties/user.dart';

abstract class UserRepository {
  Future<Either<Failure, User>> logIn(String email, String password);
  Future<Either<Failure, User>> newUser(String email, String password);
}