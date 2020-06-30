import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Subcategory extends Equatable {

  final String title;

  Subcategory({@required this.title});

  @override
  List<Object> get props => [title];

  @override
  bool get stringify => true;
}