part of 'query_bloc.dart';

abstract class QueryEvent extends Equatable {
  const QueryEvent();
}

class AddCategoryToQuery extends QueryEvent {
  final Category category;

  AddCategoryToQuery(this.category);

  @override
  List<Object> get props => [category];
}

class AddSubcategoryToQuery extends QueryEvent {
  final Subcategory subcategory;

  AddSubcategoryToQuery(this.subcategory);

  @override
  List<Object> get props => [subcategory];
}

class RemoveSubcategoryFromQuery extends QueryEvent {
  final Subcategory subcategory;

  RemoveSubcategoryFromQuery(this.subcategory);

  @override
  List<Object> get props => [subcategory];
}

class AddPriceRangeToQuery extends QueryEvent {
  final RangeValues range;

  AddPriceRangeToQuery(this.range);

  @override
  List<Object> get props => [range];
}

class AddSubTitleToQuery extends QueryEvent {
  final String subtitle;

  AddSubTitleToQuery(this.subtitle);

  @override
  List<Object> get props => [subtitle];
}

class ClearQuery extends QueryEvent {
  @override
  List<Object> get props => [];
}