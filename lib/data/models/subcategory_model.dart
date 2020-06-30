import 'package:golden_net_app/domain/enteties/subcategory.dart';

class SubcategoryModel {
  final String title;

  SubcategoryModel.fromJson(Map<String, dynamic> json) : title = json['title'];
  SubcategoryModel.fromSubcategory(Subcategory subcategory)
      : title = subcategory.title;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    return data;
  }

  Subcategory toSubcategory() {
    return Subcategory(title: this.title);
  }
}
