import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_net_app/core/failure.dart';
import 'package:golden_net_app/domain/bloc/products/products_bloc.dart';
import 'package:golden_net_app/domain/enteties/category.dart';
import 'package:golden_net_app/domain/enteties/product.dart';
import 'package:golden_net_app/domain/enteties/subcategory.dart';
import 'package:golden_net_app/domain/repositories/product_repository.dart';
import 'package:mockito/mockito.dart';

class MockProductRepository extends Mock implements ProductRepository {}

main() {
  MockProductRepository repository;
  setUp(() {
    repository = MockProductRepository();
  });

  final tProducts = List.generate(
      10,
      (index) => Product(
          title: "$index",
          description: "",
          imageUrl: "",
          price: 1,
          category: null,
          subcategories: [],
          characteristics: {}));

  final tProductsForQuery = [
    Product(
        title: "1",
        description: "descr",
        imageUrl: "www",
        price: 1,
        category: Category(
            title: "title", subcategories: [Subcategory(title: "sub")]),
        subcategories: [Subcategory(title: "sub")],
        characteristics: {}),
    Product(
        title: "2",
        description: "descr",
        imageUrl: "www",
        price: 1,
        category: Category(
            title: "title", subcategories: [Subcategory(title: "sub")]),
        subcategories: [Subcategory(title: "sub")],
        characteristics: {}),
    Product(
        title: "1",
        description: "descr",
        imageUrl: "www",
        price: 2,
        category: Category(
            title: "title", subcategories: [Subcategory(title: "sub")]),
        subcategories: [Subcategory(title: "sub")],
        characteristics: {}),
    Product(
        title: "1",
        description: "descr",
        imageUrl: "www",
        price: 1,
        category: Category(
            title: "title2", subcategories: [Subcategory(title: "sub")]),
        subcategories: [Subcategory(title: "sub")],
        characteristics: {}),
    Product(
        title: "1",
        description: "descr",
        imageUrl: "www",
        price: 1,
        category: Category(
            title: "title", subcategories: [Subcategory(title: "sub")]),
        subcategories: [],
        characteristics: {})
  ];

  final tSubtitle = "subtitle";
  final tCategory = Category(title: "title", subcategories: []);
  final tSubCategory1 = Subcategory(title: "subtitle");
  final tSubCategory2 = Subcategory(title: "subtitle2");
  final tRange = RangeValues(10, 100);

  final tFailure = BasicFailure("Error");
  group("test ProductsBloc updating part", () {
    blocTest("test UpdateProducts good scenario",
        build: () async {
          when(repository.getProducts())
              .thenAnswer((realInvocation) async => Right(tProducts));
          return ProductsBloc(repository);
        },
        act: (bloc) => bloc.add(UpdateProducts()),
        expect: [
          isA<ProductsState>()
              .having((s) => s.updating, "has updating that matching", true),
          isA<ProductsState>()
              .having((s) => s.updating, "has updating that matching", false)
              .having(
                  (s) => s.products, "has products that matching", tProducts)
        ]);

    blocTest("test UpdateProducts bad scenario",
        build: () async {
          when(repository.getProducts())
              .thenAnswer((realInvocation) async => Left(tFailure));
          return ProductsBloc(repository);
        },
        act: (bloc) => bloc.add(UpdateProducts()),
        expect: [
          isA<ProductsState>()
              .having((s) => s.updating, "has updating that matching", true),
          isA<ProductsState>()
              .having((s) => s.updating, "has updating that matching", false)
              .having((state) => state.failure, "has failure that matching",
                  tFailure)
        ]);
  });

  group("test ProductsBloc query part", () {
    blocTest("test AddSubTitleToQuery",
        build: () async => ProductsBloc(repository),
        act: (bloc) => bloc.add(
              AddSubTitleToQuery(tSubtitle),
            ),
        expect: [
          isA<ProductsState>().having((state) => state.query.subtitle,
              "has subtitle that matches", tSubtitle)
        ]);
    blocTest("test AddCategoryToQuery",
        build: () async => ProductsBloc(repository),
        act: (bloc) => bloc.add(
              AddCategoryToQuery(tCategory),
            ),
        expect: [
          isA<ProductsState>().having((state) => state.query.category,
              "has category that matches", tCategory)
        ]);
    blocTest("test AddPriceRangeToQuery",
        build: () async => ProductsBloc(repository),
        act: (bloc) => bloc.add(
              AddPriceRangeToQuery(tRange),
            ),
        expect: [
          isA<ProductsState>().having(
              (state) =>
                  RangeValues(state.query.minPrice, state.query.maxPrice),
              "has price range that matches",
              tRange)
        ]);
    blocTest("test AddSubcategoryToQuery/RemoveSubcategoryFromQuery",
        build: () async => ProductsBloc(repository),
        act: (bloc) async {
          bloc.add(AddSubcategoryToQuery(tSubCategory1));
          bloc.add(AddSubcategoryToQuery(tSubCategory2));
          bloc.add(RemoveSubcategoryFromQuery(tSubCategory1));
        },
        expect: [
          isA<ProductsState>().having((state) => state.query.subcategories,
              "has subcategories that matches", [tSubCategory1]),
          isA<ProductsState>().having((state) => state.query.subcategories,
              "has subcategories that matches", [tSubCategory1, tSubCategory2]),
          isA<ProductsState>().having((state) => state.query.subcategories,
              "has subcategories that matches", [tSubCategory2]),
        ]);
    blocTest("test ClearQuery",
        build: () async => ProductsBloc(repository),
        act: (bloc) async {
          bloc.add(AddSubTitleToQuery(tSubtitle));
          bloc.add(AddPriceRangeToQuery(tRange));
          bloc.add(AddCategoryToQuery(tCategory));
          bloc.add(AddSubcategoryToQuery(tSubCategory1));
          bloc.add(AddSubcategoryToQuery(tSubCategory2));
          bloc.add(ClearQuery());
        },
        skip: 5,
        expect: [
          isA<ProductsState>()
              .having((state) => state.query.subtitle,
                  "has subtitle that matches", tSubtitle)
              .having((state) => state.query.category,
                  "has category that matches", tCategory)
              .having(
                  (state) =>
                      RangeValues(state.query.minPrice, state.query.maxPrice),
                  "has price range that matches",
                  tRange)
              .having(
                  (state) => state.query.subcategories,
                  "has subcategories that matches",
                  [tSubCategory1, tSubCategory2]),
          isA<ProductsState>()
              .having((state) => state.query.subtitle,
                  "has subtitle that matches", "")
              .having((state) => state.query.category,
                  "has category that matches", null)
              .having(
                  (state) =>
                      RangeValues(state.query.minPrice, state.query.maxPrice),
                  "has price range that matches",
                  RangeValues(0, 0))
              .having((state) => state.query.subcategories,
                  "has subcategories that matches", []),
        ]);
  });

  group("test ProductBloc filter part", () {
    blocTest("test filterProducts", build: () async {
      when(repository.getProducts())
          .thenAnswer((realInvocation) async => Right(tProductsForQuery));
      return ProductsBloc(repository);
    }, act: (bloc) async {
      bloc.add(UpdateProducts());
      bloc.add(AddSubTitleToQuery("1"));
      bloc.add(AddPriceRangeToQuery(RangeValues(0, 1)));
      bloc.add(AddCategoryToQuery(Category(
          title: "title", subcategories: [Subcategory(title: "sub")])));
      bloc.add(AddSubcategoryToQuery(Subcategory(title: "sub")));
    }, skip: 6, expect: [
      isA<ProductsState>().having((state) => state.filteredProducts,
          "has products that matches", [tProductsForQuery[0]])
    ]);
  });
}
