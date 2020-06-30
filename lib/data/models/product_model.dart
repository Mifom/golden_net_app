import 'package:golden_net_app/domain/enteties/product.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

import 'category_model.dart';
import 'subcategory_model.dart';

@JsonSerializable(nullable: false)
class ProductModel {
  final String title;
  final String description;
  final String imageUrl;
  final double price;
  final CategoryModel category;
  final List<SubcategoryModel> subcategories;
  final Map<String, dynamic> characteristics;
  ProductModel({
    @required this.title,
    @required this.description,
    @required this.imageUrl,
    @required this.price,
    @required this.category,
    @required this.subcategories,
    @required this.characteristics
  });

  ProductModel.fromProduct(Product product)
      : title = product.title,
        description = product.description,
        imageUrl = product.imageUrl,
        price = product.price,
        category = CategoryModel.fromCategory(product.category),
        subcategories = product.subcategories
            .map((e) => SubcategoryModel.fromSubcategory(e))
            .toList(),
        characteristics = product.characteristics;

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    String title = json['title'];
    String description = json['description'];
    String imageUrl = json['imageUrl'];
    double price = json['price'];
    CategoryModel category = json['category'] != null
        ? CategoryModel.fromJson(json['category'])
        : null;
    List<SubcategoryModel> subcategories = [];
    if (json['subcategories'] != null) {
      json['subcategories'].forEach((v) {
        subcategories.add(SubcategoryModel.fromJson(v));
      });
    }
    final characteristics = json['characteristics'] as Map<String, dynamic>;
    return ProductModel(
        title: title,
        description: description,
        imageUrl: imageUrl,
        price: price,
        category: category,
        subcategories: subcategories,
        characteristics: characteristics
        );
  }

  Product toProduct() {
    return Product(
        title: title,
        description: description,
        imageUrl: imageUrl,
        price: price,
        category: category.toCategory(),
        subcategories: subcategories.map((e) => e.toSubcategory()).toList(),
        characteristics: characteristics);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['description'] = this.description;
    data['imageUrl'] = this.imageUrl;
    data['price'] = this.price;
    if (this.category != null) {
      data['category'] =
          CategoryModel.fromCategory(this.category.toCategory()).toJson();
    }
    if (this.subcategories != null) {
      data['subcategories'] =
          this.subcategories.map((v) => v.toJson()).toList();
    }
    if(this.characteristics != null) {
      data['characteristics'] = characteristics;
    }
    return data;
  }
}
