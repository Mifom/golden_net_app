import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:golden_net_app/domain/bloc/cart/cart_bloc.dart';
import 'package:golden_net_app/domain/bloc/tab/tab_bloc.dart';
import 'package:golden_net_app/domain/bloc/user/user_bloc.dart';
import 'package:golden_net_app/domain/enteties/counted_product.dart';
import 'package:golden_net_app/ui/widgets/cart_product_card.dart';

class CartPage extends StatelessWidget {
  CartPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Корзина"),
      ),
      body: BlocBuilder<CartBloc, List<CountedProduct>>(
        bloc: context.bloc(),
        builder: (context, productList) {
          if (productList.isEmpty) {
            return Center(
              child: Column(
                children: <Widget>[
                  Spacer(),
                  Text("В корзине пока нет товаров"),
                  RaisedButton(
                    child: Text("В каталог"),
                    onPressed: () => context.bloc<TabBloc>().add(1),
                  ),
                  Spacer(),
                ],
              ),
            );
          }
          return Column(
            children: <Widget>[
              Expanded(
                child: ListView.separated(
                  separatorBuilder: (context, index) => Divider(),
                  itemCount: productList.length,
                  itemBuilder: (context, index) {
                    final countedProduct = productList[index];
                    return CartProductCard(
                        countedProduct: countedProduct, tag: index);
                    // Dismissible(
                    //   key: Key(countedProduct.toString()),
                    //   onDismissed: (direction) => context.bloc<CartBloc>().add(RemoveFromCart(product: countedProduct.product)),
                    //   child: CartProductCard(countedProduct: countedProduct, tag: index)
                    // );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Expanded(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: <Widget>[
                          Flexible(
                            flex: 1,
                            fit: FlexFit.tight,
                            child: Text(
                              "Итого: ${productList.fold(0, (acc, e) => acc + e.totalPice)} р",
                              style: TextStyle(fontSize: 18.0),
                            ),
                          ),
                          Flexible(
                              flex: 1,
                              fit: FlexFit.tight,
                              child:
                                  BlocBuilder<CartBloc, List<CountedProduct>>(
                                bloc: context.bloc(),
                                builder: (context, cart) =>
                                    BlocBuilder<UserBloc, UserState>(
                                  bloc: context.bloc(),
                                  builder: (context, state) => RaisedButton(
                                      child: Text("Оформить заказ"),
                                      onPressed: () {
                                        if (state is UserLogedIn) {
                                          showDialog(
                                              context: context,
                                              builder: (context) => AlertDialog(
                                                    title: Text(
                                                        "Покупка совершена"),
                                                    actions: <Widget>[
                                                      FlatButton(
                                                        child: Text("OK"),
                                                        onPressed: () =>
                                                            Navigator.pop(
                                                                context),
                                                      ),
                                                    ],
                                                  ));
                                        } else {
                                          showDialog(
                                              context: context,
                                              builder: (context) => AlertDialog(
                                                    title: Text(
                                                        "Пользователь не найден"),
                                                    actions: <Widget>[
                                                      FlatButton(
                                                        child: Text("OK"),
                                                        onPressed: () =>
                                                            Navigator.pop(
                                                                context),
                                                      ),
                                                    ],
                                                  ));
                                        }
                                      }),
                                ),
                              ))
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
