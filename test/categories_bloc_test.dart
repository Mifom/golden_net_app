import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_net_app/core/failure.dart';
import 'package:golden_net_app/domain/bloc/category/categories_bloc.dart';
import 'package:golden_net_app/domain/enteties/category.dart';
import 'package:golden_net_app/domain/repositories/product_repository.dart';
import 'package:mockito/mockito.dart';

class MockProductRepository extends Mock implements ProductRepository {}

main() {
  MockProductRepository repository;

  setUp(() {
    repository = MockProductRepository();
  });

  final tCategories =
      List.generate(5, (index) => Category(title: "$index", subcategories: []));

  final tFailure = BasicFailure("Network error");
  group("test CategoriesBloc", () {
    blocTest("test UpdateCategories good scenario",
        build: () async {
          when(repository.getCategories())
              .thenAnswer((realInvocation) async => Right(tCategories));
          return CategoriesBloc(repository);
        },
        act: (bloc) => bloc.add(UpdateCategories()),
        expect: [
          isA<UpdatingCategoriesState>(),
          UpdatedCategoriesState(categories: tCategories)
        ]);

    blocTest("test UpdateCategories bad scenario",
        build: () async {
          when(repository.getCategories())
              .thenAnswer((realInvocation) async => Left(tFailure));
          return CategoriesBloc(repository);
        },
        act: (bloc) => bloc.add(UpdateCategories()),
        expect: [
          isA<UpdatingCategoriesState>(),
          UpdatedCategoriesState(categories: [], failure: tFailure)
        ]);
  });
}
