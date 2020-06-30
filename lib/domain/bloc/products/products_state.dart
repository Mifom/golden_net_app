part of 'products_bloc.dart';

class ProductsState extends Equatable {
  final Failure failure;
  final List<Product> products;
  final Query query;
  final bool updating;

  ProductsState(
      {@required this.products,
      @required this.query,
      @required this.updating,
      this.failure});

  double get priceMaximum => maximum(products);
  double get priceMinimum => minimum(products);

  List<Product> get filteredProducts => products.where((product) {
        if (query.category != null && product.category != query.category)
          return false;
        if (query.minPrice != null && product.price < query.minPrice)
          return false;
        if (query.maxPrice != null && product.price > query.maxPrice)
          return false;
        if (query.subtitle != null && !product.title.contains(query.subtitle))
          return false;
        if (query.subcategories != null && query.subcategories.length > 0) {
          if (product.subcategories
              .any((sc) => !query.subcategories.contains(sc))) return false;
        }
        return true;
      }).toList();

  ProductsState copyWith(
          {List<Product> products,
          Query query,
          bool updating,
          Failure failure}) =>
      ProductsState(
          products: products ?? this.products,
          query: query ?? this.query,
          updating: updating ?? this.updating,
          failure: failure);

  @override
  List<Object> get props => [products, query, updating];

  @override
  String toString() =>
      "ProductsState(products count: ${products.length}, query: $query, updating: $updating)";
}

double maximum(List<Product> products) =>
      products.fold(0, (acc, elem) => acc < elem.price ? elem.price : acc);
double minimum(List<Product> products) => products.fold(
      0, (acc, elem) => (acc == 0) || (acc > elem.price) ? elem.price : acc);