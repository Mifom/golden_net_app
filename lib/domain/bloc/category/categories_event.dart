part of 'categories_bloc.dart';

abstract class CategoriesEvent extends Equatable {
  const CategoriesEvent();
}

class UpdateCategories extends CategoriesEvent {
  @override
  List<Object> get props => [];
}