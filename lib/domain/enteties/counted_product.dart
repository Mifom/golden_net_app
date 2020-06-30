import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'product.dart';

class CountedProduct extends Equatable {
  final Product product;
  final int count;

  CountedProduct({@required this.product, @required this.count});

  @override
  List<Object> get props => [product, count];

  @override 
  bool get stringify => true;

  int get totalPice => count * product.price.toInt();
}