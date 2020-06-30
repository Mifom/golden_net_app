import 'package:golden_net_app/data/models/user_model.dart';
import 'package:golden_net_app/domain/enteties/user.dart';
import 'package:golden_net_app/core/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:golden_net_app/domain/repositories/user_repository.dart';
import 'package:localstorage/localstorage.dart';

class LocalUserRepository extends UserRepository {
  final LocalStorage storage = LocalStorage("users.json");
  Future<Either<Failure, List<User>>> getUsers() async {
    if (await storage.ready) {
      if(storage.getItem("users") as List == null) {
        await setUsers([]);
      }
      final json = storage.getItem("users") as List;
      return Right(
          json.map((userJson) => UserModel.fromJson(userJson).toUser()).toList());
    } else {
      return Left(BasicFailure("unexpected"));
    }
  }

  Future<Failure> setUsers(List<User> users) async {
    if (await storage.ready) {
      storage.setItem("users", users.map((v)=>UserModel.fromUser(v).toJson()).toList());
      return null;
    } else {
      return BasicFailure("Storage unavaliable");
    }
  }

  @override
  Future<Either<Failure, User>> logIn(String email, String password) async {
    await Future.delayed(Duration(milliseconds: 300));
    return (await getUsers()).bind((users) {
      for (var user in users) {
        if (user.email == email) {
          if (user.password == password) {
            return Right(user);
          } else {
            return Left(BasicFailure("Wrong password"));
          }
        }
      }
      return Left(BasicFailure("No such user"));
    });
  }

  @override
  Future<Either<Failure, User>> newUser(String email, String password) async {
    await Future.delayed(Duration(milliseconds: 300));
    final either = await getUsers();
    if(either.isLeft()) return either.map((r) => null);
    final users = either.getOrElse(() => null);
    for(var u in users) {
      if(u.email == email) {
        return Left(BasicFailure("User with this email already registered"));
      }
    }
    final user = UserModel(email: email, password: password);
    users.add(user.toUser());
    final failure = await setUsers(users);
    return failure != null ? Left(failure) : Right(user.toUser());
  }
}
