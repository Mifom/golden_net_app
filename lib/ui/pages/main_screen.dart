import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:golden_net_app/domain/bloc/cart/cart_bloc.dart';
import 'package:golden_net_app/domain/bloc/category/categories_bloc.dart';
import 'package:golden_net_app/domain/bloc/tab/tab_bloc.dart';
import 'package:golden_net_app/domain/enteties/counted_product.dart';
import 'package:golden_net_app/ui/pages/favorites_page.dart';

import 'cart_page.dart';
import 'categories_page.dart';
import 'home_page.dart';
import 'profile_page.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TabBloc, int>(
      bloc: context.bloc(),
      builder: (_, currentIndex) => Scaffold(
        body: IndexedStack(
          index: currentIndex,
          children: <Widget>[
            HomePage(),
            BlocProvider<CategoriesBloc>(
                create: (context) => CategoriesBloc(context.repository()),
                child: CategoriesPage()),
            FavoritesPage(),
            CartPage(),
            ProfilePage()
          ],
        ),
        bottomNavigationBar: BlocBuilder<CartBloc, List<CountedProduct>>(
          bloc: context.bloc(),
          builder: (_, cart) => BottomNavigationBar(
            unselectedItemColor: Theme.of(context).colorScheme.onPrimary,
            currentIndex: currentIndex,
            selectedItemColor: Theme.of(context).accentColor,
            backgroundColor: Theme.of(context).primaryColor,
            //unselectedItemColor: Colors.white,
            onTap: (index) {
              context.bloc<TabBloc>().add(index);
            },
            items: [
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.home),
                title: Text("Главная"),
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.collections),
                title: Text("Каталог"),
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.heart),
                title: Text("Избранное"),
              ),
              BottomNavigationBarItem(
                icon: Badge(
                  child: Icon(CupertinoIcons.shopping_cart),
                  showBadge: cart.length > 0,
                  badgeContent: Text(
                    cart.fold(0, (acc, e) => acc + e.count).toString(),
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                title: Text("Корзина"),
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.person),
                title: Text("Профиль"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
