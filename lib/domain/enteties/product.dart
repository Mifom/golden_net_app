import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'category.dart';
import 'subcategory.dart';

class Product extends Equatable {

  final String title;
  final String description;
  final String imageUrl;
  final double price;
  final Category category;
  final List<Subcategory> subcategories;
  final Map<String, dynamic> characteristics;

  Product({
    @required this.title,
    @required this.description,
    @required this.imageUrl,
    @required this.price,
    @required this.category,
    @required this.subcategories,
    @required this.characteristics
  });

  @override
  List<Object> get props => [title, description, imageUrl, price, category, subcategories, characteristics];
  
  @override
  //String toString() => "Product(title: $title, category: $category, price: $price)";
  bool get stringify => true;
}