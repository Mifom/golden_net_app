part of 'categories_bloc.dart';

abstract class CategoriesState extends Equatable {
  final Failure failure;
  CategoriesState({this.failure});
}

class UpdatedCategoriesState extends CategoriesState {

  final List<Category> categories;

  UpdatedCategoriesState({@required this.categories, Failure failure}):super(failure: failure);

  @override
  List<Object> get props => [categories];

  @override
  bool get stringify => true;
}

class UpdatingCategoriesState extends CategoriesState {

  final List<Category> categories;

  UpdatingCategoriesState({@required this.categories});

  @override
  List<Object> get props => [categories];

  @override
  bool get stringify => true;
}