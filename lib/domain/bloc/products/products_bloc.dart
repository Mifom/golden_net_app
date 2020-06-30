import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:golden_net_app/core/failure.dart';
import 'package:golden_net_app/domain/enteties/category.dart';
import 'package:golden_net_app/domain/enteties/product.dart';
import 'package:golden_net_app/domain/enteties/subcategory.dart';
import 'package:golden_net_app/domain/repositories/product_repository.dart';

part 'products_event.dart';
part 'products_state.dart';
part 'query.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final ProductRepository _repository;

  ProductsBloc(ProductRepository repository)
      : _repository = repository;

  @override
  ProductsState get initialState =>
      ProductsState(products: [], query: initialQuery, updating: false);

  Query get initialQuery => Query(
      category: null,
      minPrice: 0,
      maxPrice: 0,
      subcategories: [],
      subtitle: "");

  @override
  Stream<ProductsState> mapEventToState(ProductsEvent event) async* {
    if (event is UpdateProducts) {
      yield state.copyWith(updating: true);
      final either = await _repository.getProducts();
      yield either.fold(
          (failure) => state.copyWith(failure: failure, updating: false),
          (products) => state.copyWith(
              products: products,
              updating: false,
              query: state.query.copyWith(
                  minPrice: minimum(products), maxPrice: maximum(products))));
    }
    if (event is AddCategoryToQuery) {
      yield state.copyWith(
          query: state.query.copyWith(category: event.category));
    } else if (event is AddPriceRangeToQuery) {
      yield state.copyWith(
          query: state.query.copyWith(
              minPrice: event.range.start.ceil().toDouble(),
              maxPrice: event.range.end.ceil().toDouble()));
    } else if (event is AddSubTitleToQuery) {
      yield state.copyWith(
          query: state.query.copyWith(subtitle: event.subtitle));
    } else if (event is AddSubcategoryToQuery) {
      yield state.copyWith(
          query: state.query.copyWith(subcategories: [
        ...state.query.subcategories,
        event.subcategory
      ]));
    } else if (event is RemoveSubcategoryFromQuery) {
      yield state.copyWith(
          query: state.query.copyWith(
              subcategories: state.query.subcategories
                  .where((subcategory) => subcategory != event.subcategory)
                  .toList()));
    } else if (event is ClearQuery) {
      yield state.copyWith(
          query: initialQuery.copyWith(
              minPrice: state.priceMinimum, maxPrice: state.priceMaximum));
    }
  }
}
