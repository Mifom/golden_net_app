import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'subcategory.dart';

class Category extends Equatable {

  final String title;
  final List<Subcategory> subcategories;

  Category({@required this.title, @required this.subcategories});

  @override
  List<Object> get props => [title, subcategories];

  @override
  toString() => "Category('$title')";
}