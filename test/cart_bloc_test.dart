import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_net_app/domain/bloc/cart/cart_bloc.dart';
import 'package:golden_net_app/domain/enteties/counted_product.dart';
import 'package:golden_net_app/domain/enteties/product.dart';

main() {
  final tProduct1 = Product(
      title: "Product 1",
      description: "",
      imageUrl: "",
      price: 1,
      category: null,
      subcategories: [],
      characteristics: {});
  final tProduct2 = Product(
      title: "Product 2",
      description: "",
      imageUrl: "",
      price: 1,
      category: null,
      subcategories: [],
      characteristics: {});
  group("test CartBloc", () {
    blocTest("add product1 one time",
        build: () async => CartBloc(),
        act: (bloc) => bloc.add(AddToCart(product: tProduct1)),
        expect: [
          [CountedProduct(product: tProduct1, count: 1)],
        ]);

    blocTest("add product1 3 times",
        build: () async => CartBloc(),
        act: (bloc) async {
          bloc.add(AddToCart(product: tProduct1));
          bloc.add(AddToCart(product: tProduct1));
          bloc.add(AddToCart(product: tProduct1));
        },
        expect: [
          [CountedProduct(product: tProduct1, count: 1)],
          [CountedProduct(product: tProduct1, count: 2)],
          [CountedProduct(product: tProduct1, count: 3)],
        ]);

    blocTest("add product1 one time and product2 two times",
        build: () async => CartBloc(),
        act: (bloc) async {
          bloc.add(AddToCart(product: tProduct1));
          bloc.add(AddToCart(product: tProduct2));
          bloc.add(AddToCart(product: tProduct2));
        },
        expect: [
          [CountedProduct(product: tProduct1, count: 1)],
          [
            CountedProduct(product: tProduct1, count: 1),
            CountedProduct(product: tProduct2, count: 1)
          ],
          [
            CountedProduct(product: tProduct1, count: 1),
            CountedProduct(product: tProduct2, count: 2)
          ],
        ]);
    blocTest(
        "add product1 one time and product2 two times, then delete product1 and product2",
        build: () async => CartBloc(),
        act: (bloc) async {
          bloc.add(AddToCart(product: tProduct1));
          bloc.add(AddToCart(product: tProduct2));
          bloc.add(AddToCart(product: tProduct2));
          bloc.add(RemoveFromCart(product: tProduct1));
          bloc.add(RemoveFromCart(product: tProduct2));
        },
        expect: [
          [CountedProduct(product: tProduct1, count: 1)],
          [
            CountedProduct(product: tProduct1, count: 1),
            CountedProduct(product: tProduct2, count: 1)
          ],
          [
            CountedProduct(product: tProduct1, count: 1),
            CountedProduct(product: tProduct2, count: 2)
          ],
          [CountedProduct(product: tProduct2, count: 2)],
          [CountedProduct(product: tProduct2, count: 1)],
        ]);
  });
}
