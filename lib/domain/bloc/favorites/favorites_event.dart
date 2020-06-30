part of 'favorites_bloc.dart';

abstract class FavoritesEvent extends Equatable {
  const FavoritesEvent();
}

class AddToFavorites extends FavoritesEvent {
  final Product product;
  const AddToFavorites(this.product);
  @override
  List<Object> get props => [product];
}

class RemoveFromFavorites extends FavoritesEvent {
  final Product product;
  const RemoveFromFavorites(this.product);
  @override
  List<Object> get props => [product];
}

class _SetState extends FavoritesEvent {
  final List<Product> products;
  _SetState(this.products);
  @override
  List<Object> get props => [products];
}
