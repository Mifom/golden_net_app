import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:golden_net_app/core/failure.dart';
import 'package:golden_net_app/domain/enteties/category.dart';
import 'package:golden_net_app/domain/repositories/product_repository.dart';

part 'categories_event.dart';
part 'categories_state.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  final ProductRepository _repository;

  CategoriesBloc(this._repository);

  @override
  CategoriesState get initialState => UpdatedCategoriesState(categories: []);

  @override
  Stream<CategoriesState> mapEventToState(CategoriesEvent event) async* {
    if (event is UpdateCategories) {
      final s = state;
      if (s is UpdatedCategoriesState) {
        yield UpdatingCategoriesState(categories: s.categories);
        final either = await _repository.getCategories();
        yield either.fold(
            (failure) => UpdatedCategoriesState(
                categories: s.categories, failure: failure),
            (categories) => UpdatedCategoriesState(categories: categories));
      }
    }
  }
}
