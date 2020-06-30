import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:golden_net_app/domain/enteties/category.dart';
import 'package:golden_net_app/domain/enteties/subcategory.dart';

part 'query_event.dart';
part 'query_state.dart';

class QueryBloc extends Bloc<QueryEvent, Query> {
  @override
  Query get initialState => Query(
      category: null,
      subcategories: [],
      minPrice: null,
      maxPrice: null,
      subtitle: "");

  @override
  Stream<Query> mapEventToState(
    QueryEvent event,
  ) async* {
    if (event is AddCategoryToQuery) {
      yield state.copyWith(category: event.category);
    } else if (event is AddPriceRangeToQuery) {
      yield state.copyWith(minPrice: event.range.start, maxPrice: event.range.end);
    } else if (event is AddSubTitleToQuery) {
      yield state.copyWith(subtitle: event.subtitle);
    } else if (event is AddSubcategoryToQuery) {
      yield state
          .copyWith(subcategories: [...state.subcategories, event.subcategory]);
    } else if (event is RemoveSubcategoryFromQuery) {
       yield state.copyWith(
          subcategories: state.subcategories
              .where((subcategory) => subcategory != event.subcategory).toList());
    } else if(event is ClearQuery) {
      yield initialState;
    }
  }
}
