import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:golden_net_app/domain/bloc/category/categories_bloc.dart';
import 'package:golden_net_app/domain/bloc/products/products_bloc.dart';
import 'package:golden_net_app/ui/pages/products_page.dart';
import 'package:golden_net_app/ui/widgets/two_page_slider.dart';

class CategoriesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    context.bloc<CategoriesBloc>().add(UpdateCategories());
    return TwoPageSlider(
      builder: (context, goForward) => Scaffold(
        appBar: AppBar(
          title: Text("Каталог"),
        ),
        body: BlocBuilder<CategoriesBloc, CategoriesState>(
          bloc: context.bloc(),
          builder: (context, state) {
            if (state is UpdatingCategoriesState) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is UpdatedCategoriesState) {
              return ListView.separated(
                itemCount: state.categories.length,
                separatorBuilder: (context, index) =>
                    Divider(/*indent: 30.0,*/), //whith icons
                itemBuilder: (context, index) {
                  final category = state.categories[index];
                  return ListTile(
                    title: Text(category.title),
                    trailing: Icon(Icons.chevron_right),
                    onTap: () {
                      goForward(
                          builder: (context, goBack) =>
                              BlocProvider<ProductsBloc>(
                                create: (context) =>
                                    ProductsBloc(context.repository()),
                                child: ProductsPage(
                                  category: category,
                                  goBackward: goBack,
                                ),
                              ),
                          transitionType: SharedAxisTransitionType.horizontal);
                    },
                  );
                },
              );
            } else {
              return Center(
                child: Text("No categories"),
              );
            }
          },
        ),
      ),
    );
  }
}
