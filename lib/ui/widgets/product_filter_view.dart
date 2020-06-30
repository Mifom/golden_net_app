import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:golden_net_app/domain/bloc/products/products_bloc.dart';

class ProductFilterView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(),
          child: BlocBuilder<ProductsBloc, ProductsState>(
        bloc: context.bloc(),
        builder: (context, state) {
          if (state.products.length == 0) {
            return Center(
              child: Text("Продукты не найдены"),
            );
          }
          return Column(
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                child: Text(
                  "Фильтры",
                  style: TextStyle(fontSize: 30),
                ),
              ),
              Divider(),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Цена"),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Expanded(
                    child: RangeSlider(
                      min: state.priceMinimum,
                      max: state.priceMaximum,
                      values:
                          RangeValues(state.query.minPrice, state.query.maxPrice),
                      onChanged: (value) {
                        context
                            .bloc<ProductsBloc>()
                            .add(AddPriceRangeToQuery(value));
                      },
                      activeColor: Theme.of(context).colorScheme.onPrimary,
                      inactiveColor: Colors.grey[300],
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child:
                    Text("от ${state.query.minPrice.toInt()} до ${state.query.maxPrice.toInt()}"),
              ),
              Divider(),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Подкатегории"),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Wrap(
                      spacing: 5.0,
                      runSpacing: 3.0,
                      children: state.query.category.subcategories
                          .map((e) => FilterChip(
                              label: Text(e.title),
                              onSelected: (isSelected) {
                                if (isSelected) {
                                  context
                                      .bloc<ProductsBloc>()
                                      .add(AddSubcategoryToQuery(e));
                                } else {
                                  context
                                      .bloc<ProductsBloc>()
                                      .add(RemoveSubcategoryFromQuery(e));
                                }
                              },
                              selected: state.query.subcategories.contains(e)))
                          .toList()),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
