import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_net_app/domain/bloc/query/query_bloc.dart';
import 'package:golden_net_app/domain/enteties/category.dart';
import 'package:golden_net_app/domain/enteties/subcategory.dart';

main() {

  final tSubtitle = "subtitle";
  final tCategory = Category(title: "title", subcategories: []);
  final tSubCategory1 = Subcategory(title: "subtitle");
  final tSubCategory2 = Subcategory(title: "subtitle2");
  final tRange = RangeValues(10, 100);
  group("test QueryBloc", () {
    blocTest("test AddSubTitleToQuery",
        build: () async => QueryBloc(),
        act: (bloc) => bloc.add(
              AddSubTitleToQuery(tSubtitle),
            ),
        expect: [
          isA<Query>().having(
              (state) => state.subtitle, "has subtitle that matches", tSubtitle)
        ]);
        blocTest("test AddCategoryToQuery",
        build: () async => QueryBloc(),
        act: (bloc) => bloc.add(
              AddCategoryToQuery(tCategory),
            ),
        expect: [
          isA<Query>().having(
              (state) => state.category, "has category that matches", tCategory)
        ]);
        blocTest("test AddPriceRangeToQuery",
        build: () async => QueryBloc(),
        act: (bloc) => bloc.add(
              AddPriceRangeToQuery(tRange),
            ),
        expect: [
          isA<Query>().having(
              (state) => RangeValues(state.minPrice, state.maxPrice), "has price range that matches", tRange)
        ]);
        blocTest("test AddSubcategoryToQuery/RemoveSubcategoryFromQuery",
        build: () async => QueryBloc(),
        act: (bloc) async {
          bloc.add(AddSubcategoryToQuery(tSubCategory1));
          bloc.add(AddSubcategoryToQuery(tSubCategory2));
          bloc.add(RemoveSubcategoryFromQuery(tSubCategory1));
        },
        expect: [
          isA<Query>().having(
              (state) => state.subcategories, "has subcategories that matches", [tSubCategory1]),
          isA<Query>().having(
              (state) => state.subcategories, "has subcategories that matches", [tSubCategory1, tSubCategory2]),
          isA<Query>().having(
              (state) => state.subcategories, "has subcategories that matches", [tSubCategory2]),
        ]);
        blocTest("test ClearQuery",
        build: () async => QueryBloc(),
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
          isA<Query>().having(
              (state) => state.subtitle, "has subtitle that matches", tSubtitle)
              .having(
              (state) => state.category, "has category that matches", tCategory)
              .having(
              (state) => RangeValues(state.minPrice, state.maxPrice), "has price range that matches", tRange)
              .having(
              (state) => state.subcategories, "has subcategories that matches", [tSubCategory1, tSubCategory2]),
          isA<Query>().having(
              (state) => state.subtitle, "has subtitle that matches", "")
              .having(
              (state) => state.category, "has category that matches", null)
              .having(
              (state) => RangeValues(state.minPrice, state.maxPrice), "has price range that matches", RangeValues(null,null))
              .having(
              (state) => state.subcategories, "has subcategories that matches", []),
        ]);
  });
}
