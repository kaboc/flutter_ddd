import 'package:meta/meta.dart';
import 'package:flutter_ddd/domain/category/value/category_id.dart';
import 'package:flutter_ddd/domain/category/value/category_name.dart';

export 'package:flutter_ddd/domain/category/value/category_id.dart';
export 'package:flutter_ddd/domain/category/value/category_name.dart';

class Category {
  final CategoryId id;
  CategoryName _name;

  Category({@required this.id, @required CategoryName name}) : _name = name;

  CategoryName get name => _name;

  @override
  // ignore: avoid_equals_and_hash_code_on_mutable_classes
  bool operator ==(Object other) =>
      identical(other, this) || (other is Category && other.id == id);

  @override
  // ignore: avoid_equals_and_hash_code_on_mutable_classes
  int get hashCode => runtimeType.hashCode ^ id.hashCode;

  void changeName(CategoryName newName) {
    _name = newName;
  }
}
