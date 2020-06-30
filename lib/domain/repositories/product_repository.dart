import 'package:dartz/dartz.dart';
import 'package:golden_net_app/core/failure.dart';
import '../enteties/category.dart';
import '../enteties/product.dart';

abstract class ProductRepository {
  Future<Either<Failure, List<Product>>> getProducts();
  Future<Either<Failure, List<Category>>> getCategories();
}