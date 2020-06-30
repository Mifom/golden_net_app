import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:golden_net_app/data/repositories/local_favorites_repository.dart';
import 'package:golden_net_app/data/repositories/local_user_repository.dart';
import 'package:golden_net_app/data/repositories/stub_product_repository.dart';
import 'package:golden_net_app/domain/bloc/favorites/favorites_bloc.dart';
import 'package:golden_net_app/domain/repositories/favorites_repository.dart';
import 'package:golden_net_app/domain/repositories/product_repository.dart';
import 'package:golden_net_app/domain/repositories/user_repository.dart';
import 'package:golden_net_app/theme.dart';
import 'package:golden_net_app/ui/pages/main_screen.dart';

import 'domain/bloc/cart/cart_bloc.dart';
import 'domain/bloc/tab/tab_bloc.dart';
import 'domain/bloc/user/user_bloc.dart';

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();
  runApp(App());
}

class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<ProductRepository>(
          create: (context) => StubProductRepository(),
        ),
        RepositoryProvider<UserRepository>(
          create: (context) => LocalUserRepository(),
        ),
        RepositoryProvider<FavoritesRepository>(
          create: (context) => LocalFavoritesRepository(),
        )
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<TabBloc>(
            create: (context) => TabBloc(),
          ),
          BlocProvider<CartBloc>(
            create: (context) => CartBloc(),
          ),
          BlocProvider<UserBloc>(
            create: (context) => UserBloc(context.repository()),
          ),
          BlocProvider<FavoritesBloc>(
            create: (context) => FavoritesBloc(context.repository()),
          )
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: themeData,
          home: MainScreen(),
        ),
      ),
    );
  }
}

class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onEvent(Bloc bloc, Object event) {
    print(event);
    super.onEvent(bloc, event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    print(transition);
    super.onTransition(bloc, transition);
  }

  @override
  void onError(Bloc bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    print('$error, $stackTrace');
  }
}
