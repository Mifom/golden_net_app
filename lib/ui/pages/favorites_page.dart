import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:golden_net_app/domain/bloc/favorites/favorites_bloc.dart';
import 'package:golden_net_app/domain/bloc/tab/tab_bloc.dart';
import 'package:golden_net_app/domain/enteties/product.dart';
import 'package:golden_net_app/ui/widgets/product_card.dart';

class FavoritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Избранное"),
      ),
      body: BlocBuilder<FavoritesBloc, List<Product>>(
        bloc: context.bloc(),
        builder: (context, favoritesList) {
          if (favoritesList.isEmpty) {
            return Center(
              child: Column(
                children: <Widget>[
                  Spacer(),
                  Text("В избранном пока нет товаров"),
                  RaisedButton(
                    child: Text("В каталог"),
                    onPressed: () => context.bloc<TabBloc>().add(1),
                  ),
                  Spacer(),
                ],
              ),
            );
          }
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisSpacing: 4,
              crossAxisSpacing: 4,
              crossAxisCount: 2,
              childAspectRatio: 0.67,
            ),
            itemCount: favoritesList.length,
            itemBuilder: (context, index) =>
                ProductCard(product: favoritesList[index]),
          );
        },
      ),
    );
  }
}
