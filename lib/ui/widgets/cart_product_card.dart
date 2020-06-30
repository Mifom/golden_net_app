import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:golden_net_app/domain/bloc/cart/cart_bloc.dart';
import 'package:golden_net_app/domain/enteties/counted_product.dart';
import 'package:golden_net_app/ui/widgets/product_info_wrapper.dart';

class CartProductCard extends StatelessWidget {
  final CountedProduct countedProduct;
  final Object tag;

  CartProductCard({@required this.countedProduct, @required this.tag});

  @override
  Widget build(BuildContext context) {
    return ProductInfoWrapper(
      product: countedProduct.product,
      height: 200,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Row(
          children: <Widget>[
            Hero(
              tag: tag,
              child: Image.network(
                countedProduct.product.imageUrl,
                height: 200,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Align(alignment: Alignment.centerLeft,
                    child: Text(countedProduct.product.title, style: TextStyle(fontSize: 20),)),
                  Divider(),
                  Text("Категория: ${countedProduct.product.category.title}"),
                  Row(
                    children: <Widget>[
                      IconButton(
                          icon: Icon(Icons.remove),
                          onPressed: () => context.bloc<CartBloc>().add(
                              RemoveFromCart(product: countedProduct.product))),
                      Text(countedProduct.count.toString()),
                      IconButton(
                          icon: Icon(Icons.add),
                          onPressed: () => context
                              .bloc<CartBloc>()
                              .add(AddToCart(product: countedProduct.product))),
                    ],
                  ),
                  Divider(),
                  Text("Итого: ${countedProduct.totalPice} р")
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
