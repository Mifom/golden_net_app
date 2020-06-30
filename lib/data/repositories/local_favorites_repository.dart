import 'package:golden_net_app/data/models/product_model.dart';
import 'package:golden_net_app/domain/enteties/product.dart';
import 'package:golden_net_app/core/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:golden_net_app/domain/repositories/favorites_repository.dart';
import 'package:localstorage/localstorage.dart';

class LocalFavoritesRepository implements FavoritesRepository {
  final LocalStorage storage = LocalStorage("favorites.json");

  @override
  Future<Either<Failure, List<Product>>> get favoriteProducts async {
    if (await storage.ready) {
      if (storage.getItem("favorites") as List == null) {
        await setFavorites([]);
      }
      final json = storage.getItem("favorites") as List;
      return Right(
          json.map((userJson) => ProductModel.fromJson(userJson).toProduct()).toList());
    } else {
      return Left(BasicFailure("unexpected"));
    }
  }

  Future<Option<Failure>> setFavorites(List<Product> favorites) async {
    if (await storage.ready) {
      storage.setItem(
          "favorites", favorites.map((v) => ProductModel.fromProduct(v).toJson()).toList());
      return None();
    } else {
      return Some(BasicFailure("Storage unavaliable"));
    }
  }

  @override
  Future<Option<Failure>> addToFavorites(Product product) async {
    final either = await favoriteProducts;
    if (either.isLeft()) return either.swap().toOption();
    return await setFavorites([...either.getOrElse(() => []), product]);
  }

  @override
  Future<Option<Failure>> removeFromFavorites(Product product) async {
    final either = await favoriteProducts;
    if (either.isLeft()) return either.swap().toOption();
    return await setFavorites(
        either.getOrElse(() => []).where((element) => element != product).toList());
  }
}
