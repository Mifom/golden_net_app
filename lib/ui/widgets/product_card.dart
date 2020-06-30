import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:golden_net_app/domain/bloc/favorites/favorites_bloc.dart';
import 'package:golden_net_app/domain/enteties/product.dart';
import 'package:golden_net_app/ui/widgets/product_info_wrapper.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({Key key, this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProductInfoWrapper(
      product: product,
      height: 300,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Row(
              children: <Widget>[
                Text("${product.price.toInt()} р"),
                Spacer(),
                BlocBuilder<FavoritesBloc, List<Product>>(
                  bloc: context.bloc(),
                  builder: (context, favItems) {
                    if(favItems.contains(product)) {
                      return IconButton(
                      icon: Icon(CupertinoIcons.heart_solid),
                      onPressed: () {
                        context.bloc<FavoritesBloc>().add(RemoveFromFavorites(product));
                      });
                    } else {
                      return IconButton(
                      icon: Icon(CupertinoIcons.heart),
                      onPressed: () {
                        context.bloc<FavoritesBloc>().add(AddToFavorites(product));
                      });
                    }
                  }
                )
              ],
            ),
          ),
          Text(product.title)
        ],
      ),
    );
  }
}
