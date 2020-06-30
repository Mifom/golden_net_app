part of 'query_bloc.dart';

class Query extends Equatable {
  final String subtitle;
  final Category category;
  final List<Subcategory> subcategories;
  final double minPrice;
  final double maxPrice;

  Query(
      {@required this.subtitle,
      @required this.category,
      @required this.subcategories,
      @required this.minPrice,
      @required this.maxPrice});

  @override
  List<Object> get props => [subtitle, category, subcategories, minPrice, maxPrice];

  @override 
  bool get stringify => true;

  Query copyWith(
          {String subtitle,
          Category category,
          List<Subcategory> subcategories,
          double minPrice,
          double maxPrice}) =>
      Query(
        subtitle: subtitle ?? this.subtitle,
        category: category ?? this.category,
        subcategories: subcategories ?? this.subcategories,
        minPrice: minPrice ?? this.minPrice,
        maxPrice: maxPrice ?? this.maxPrice,
      );
}
