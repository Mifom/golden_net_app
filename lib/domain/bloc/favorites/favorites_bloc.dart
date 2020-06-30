import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:golden_net_app/domain/enteties/product.dart';
import 'package:golden_net_app/domain/repositories/favorites_repository.dart';

part 'favorites_event.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, List<Product>> {
  final FavoritesRepository repository;

  FavoritesBloc(this.repository) {
    repository.favoriteProducts
        .then((value) => add(_SetState(value.getOrElse(() => []))));
  }

  @override
  List<Product> get initialState => [];

  @override
  Stream<List<Product>> mapEventToState(
    FavoritesEvent event,
  ) async* {
    if (event is AddToFavorites) {
      await repository.addToFavorites(event.product);
      yield (await repository.favoriteProducts).getOrElse(() => state);
    }
    if (event is RemoveFromFavorites) {
      await repository.removeFromFavorites(event.product);
      yield (await repository.favoriteProducts).getOrElse(() => state);
    }
    if (event is _SetState) {
      yield event.products;
    }
  }
}
