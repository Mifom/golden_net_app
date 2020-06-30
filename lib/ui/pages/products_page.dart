import 'package:backdrop/backdrop.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:golden_net_app/domain/bloc/products/products_bloc.dart';
import 'package:golden_net_app/domain/enteties/category.dart';
import 'package:golden_net_app/ui/widgets/product_card.dart';
import 'package:golden_net_app/ui/widgets/product_filter_view.dart';

class ProductsPage extends StatelessWidget {
  final Category category;
  final VoidCallback goBackward;

  ProductsPage({@required this.category, this.goBackward});

  @override
  Widget build(BuildContext context) {
    return BackdropScaffold(
      leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: goBackward),
      iconPosition: BackdropIconPosition.action,
      title: Text("${category.title}"),
      frontLayer: BlocBuilder<ProductsBloc, ProductsState>(
          bloc: context.bloc(),
          builder: (context, state) {
            if (state.products.length == 0) {
              if(state.updating == true) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if(state.failure == null) {
                context.bloc<ProductsBloc>().add(UpdateProducts());
                context.bloc<ProductsBloc>().add(AddCategoryToQuery(category));
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Center(
                child: Text("Продукты не найдены"),
              );
            } else {
              return Column(
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    height: 30.0,
                    child: Text(
                      "Всего товаров: ${state.filteredProducts.length}",
                      style: TextStyle(fontSize: 20, color: Colors.grey),
                    ),
                  ),
                  Expanded(
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        mainAxisSpacing: 4,
                        crossAxisSpacing: 4,
                          crossAxisCount: 2,
                          childAspectRatio: 0.67,
                        ),
                      itemCount: state.filteredProducts.length,
                      itemBuilder: (context, index) => ProductCard(product: state.filteredProducts[index]),
                    ),
                  ),
                ],
              );
            }
          }),
      backLayer: ProductFilterView(),
    );
  }
}
