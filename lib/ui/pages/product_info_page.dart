import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:golden_net_app/domain/bloc/cart/cart_bloc.dart';
import 'package:golden_net_app/domain/bloc/favorites/favorites_bloc.dart';
import 'package:golden_net_app/domain/bloc/tab/tab_bloc.dart';
import 'package:golden_net_app/domain/enteties/product.dart';

class ProductInfoPage extends StatelessWidget {
  final Product product;
  final VoidCallback back;

  ProductInfoPage({@required this.product, @required this.back});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
        elevation: 0,
        backgroundColor: Theme.of(context).canvasColor,
        textTheme: Theme.of(context).textTheme,
        iconTheme: Theme.of(context).iconTheme,
        leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: back),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              child: Stack(children: [
                Image.network(
                  product.imageUrl,
                  fit: BoxFit.cover,
                ),
                BlocBuilder<FavoritesBloc, List<Product>>(
                  bloc: context.bloc(),
                  builder: (context, favItems) {
                    if(favItems.contains(product)) {
                      return IconButton(icon: Icon(Icons.favorite), onPressed: ()=>context.bloc<FavoritesBloc>().add(RemoveFromFavorites(product)));
                    } else {
                      return IconButton(icon: Icon(Icons.favorite_border), onPressed: ()=>context.bloc<FavoritesBloc>().add(AddToFavorites(product)));
                    }
                  },
                ),
              ]),
              height: 400,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  product.title,
                  style: TextStyle(fontSize: 30),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "${product.price.toInt()} р",
                  style: TextStyle(fontSize: 30),
                ),
              ),
            ),
            Divider(),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("Информация"),
              ),
            ),
            // ListView.builder(itemBuilder: (context, index) {
            //     final c = product.characteristics.entries.elementAt(index);
            //     return Container(
            //       color:  Colors.grey[index.isEven ? 400 : 300],
            //       child: Row(
            //         mainAxisAlignment: MainAxisAlignment.spaceAround,
            //         children: <Widget>[
            //           Text(c.key),
            //           Text(c.value.toString())
            //         ],
            //       ),
            //     );
            //   },
            //   shrinkWrap: true,
            //   itemCount: product.characteristics.length),
            DataTable(
              sortColumnIndex: 0,
              columnSpacing: 150,
              columns: const [
                DataColumn(label: Text("Характеристика")),
                DataColumn(label: Text("Значение")),
              ],
              rows: product.characteristics.entries.map((c) {
                return DataRow(cells: [
                  DataCell(Text(c.key)),
                  DataCell(Text(c.value.toString())),
                ]);
              }).toList(),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  "Категория: ${product.category.title}",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
            Row(
              children: <Widget>[
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      "Подкатегории: ",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
                Wrap(
                  children: product.subcategories
                      .map((e) => Chip(label: Text(e.title)))
                      .toList(),
                )
              ],
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(product.description),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Builder(
        builder: (context) => FloatingActionButton(
          child: Icon(Icons.add_shopping_cart),
          onPressed: () {
            context.bloc<CartBloc>().add(AddToCart(product: product));
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text("${product.title} в корзине"),
              ),
              action: SnackBarAction(label: "В корзину",
              textColor: Theme.of(context).colorScheme.onSecondary,
               onPressed: () {
                context.bloc<TabBloc>().add(3);
                back();
              }),
            ));
          },
        ),
      ),
    );
  }
}
