import 'dart:math';

import 'package:dartz/dartz.dart';
import 'package:golden_net_app/core/failure.dart';
import 'package:golden_net_app/domain/enteties/category.dart';
import 'package:golden_net_app/domain/enteties/product.dart';
import 'package:golden_net_app/domain/enteties/subcategory.dart';
import 'package:golden_net_app/domain/repositories/product_repository.dart';

class StubProductRepository implements ProductRepository {
  List<Category> categories;
  List<Product> products;

  StubProductRepository() {
    final subcategories = [
      Subcategory(title: "Золото"),
      Subcategory(title: "Серебро"),
      Subcategory(title: "С бриллиантами")
    ];
    categories = [
      Category(
          title: "Кольца",
          subcategories: [...subcategories, Subcategory(title: "Обручальные")]),
      Category(
          title: "Серьги",
          subcategories: [...subcategories, Subcategory(title: "Пусеты")]),
      Category(
          title: "Подвески",
          subcategories: [...subcategories, Subcategory(title: "Крестики")]),
      Category(title: "Браслеты", subcategories: [
        ...subcategories,
        Subcategory(title: "Браслеты-цепочки")
      ])
    ];

    products = categories
        .expand((category) => List<Product>.generate(
            30,
            (index) => Product(
                    title: "${category.title} $index",
                    description: "${category.title} $index",
                    imageUrl:
                        "https://trudiamonds.s3.amazonaws.com/p/alt/xl/T2899-GC_3.jpg",
                    price: (Random(index).nextInt(90) + 4.0) * 1000,
                    category: category,
                    subcategories: [
                      category.subcategories[
                          Random(index).nextInt(category.subcategories.length)]
                    ],
                    characteristics: {"Диаметр": 10, "Тип": category.subcategories[
                          Random(index).nextInt(category.subcategories.length)].title})))
        .toList();
  }

  static const errorProbability = 0; // %
  static final failure = BasicFailure("No internet");

  Future<Either<Failure, T>> maybeReturn<T>(T obj) async {
    await Future.delayed(Duration(milliseconds: 400));
    if (Random().nextInt(100)+1 <= errorProbability) {
      return Left(failure);
    } else {
      return Right(obj);
    }
  }

  @override
  Future<Either<Failure, List<Category>>> getCategories() =>
      maybeReturn(categories);

  @override
  Future<Either<Failure, List<Product>>> getProducts() => maybeReturn(products);
}
