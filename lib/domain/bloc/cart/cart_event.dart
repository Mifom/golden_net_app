part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();
  @override
  bool get stringify => true;
}

class AddToCart extends CartEvent {
  final Product product;

  AddToCart({@required this.product});

  @override
  List<Object> get props => [product];
}

class RemoveFromCart extends CartEvent {
  final Product product;

  RemoveFromCart({@required this.product});

  @override
  List<Object> get props => [product];
}
