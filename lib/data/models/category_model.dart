import 'package:golden_net_app/data/models/subcategory_model.dart';
import 'package:golden_net_app/domain/enteties/category.dart';
import 'package:meta/meta.dart';

class CategoryModel {
  final String title;
  final List<SubcategoryModel> subcategories;

  CategoryModel({@required this.title, @required this.subcategories});

  CategoryModel.fromCategory(Category category)
      : title = category.title,
        subcategories = category.subcategories
            .map((e) => SubcategoryModel.fromSubcategory(e)).toList();

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    String title = json['title'];
    List<SubcategoryModel> subcategories = [];
    if (json['subcategories'] != null) {
      json['subcategories'].forEach((v) {
        subcategories.add(SubcategoryModel.fromJson(v));
      });
    }
    return CategoryModel(title: title, subcategories: subcategories);
  }

  Category toCategory() {
    return Category(title: title, subcategories: subcategories.map((e) => e.toSubcategory()).toList());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['title'] = this.title;
    if (this.subcategories != null) {
      data['subcategories'] = this
          .subcategories
          .map((v) => v.toJson())
          .toList();
    }
    return data;
  }
}
