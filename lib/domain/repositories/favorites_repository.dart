import 'package:dartz/dartz.dart';
import 'package:golden_net_app/core/failure.dart';
import 'package:golden_net_app/domain/enteties/product.dart';

abstract class FavoritesRepository {
  Future<Either<Failure, List<Product>>> get favoriteProducts;
  Future<Option<Failure>> addToFavorites(Product product);
  Future<Option<Failure>> removeFromFavorites(Product product);
}