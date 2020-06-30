import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:golden_net_app/domain/enteties/counted_product.dart';
import 'package:golden_net_app/domain/enteties/product.dart';

part 'cart_event.dart';

class CartBloc extends Bloc<CartEvent, List<CountedProduct>> {
  @override
  List<CountedProduct> get initialState => [];

  @override
  Stream<List<CountedProduct>> mapEventToState(CartEvent event) async* {
    final products = List<CountedProduct>.from(state);
    if (event is AddToCart) {
      final index =
          products.indexWhere((element) => element.product == event.product);
      if (index >= 0) {
        products[index] = CountedProduct(
            product: event.product, count: products[index].count + 1);
      } else {
        products.add(CountedProduct(product: event.product, count: 1));
      }
    } else if (event is RemoveFromCart) {
      final index =
          products.indexWhere((element) => element.product == event.product);
      if (index >= 0) {
        if (products[index].count == 1) {
          products.removeAt(index);
        } else {
          products[index] = CountedProduct(
              product: event.product, count: products[index].count - 1);
        }
      }
    }
    yield products;
  }
}
