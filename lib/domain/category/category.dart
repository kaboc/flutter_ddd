import 'package:meta/meta.dart';
import 'package:flutter_ddd/domain/category/value/category_id.dart';
import 'package:flutter_ddd/domain/category/value/category_name.dart';

export 'package:flutter_ddd/domain/category/value/category_id.dart';
export 'package:flutter_ddd/domain/category/value/category_name.dart';

@immutable
class Category {
  final CategoryId id;
  final CategoryName name;

  const Category({@required this.id, @required this.name});

  @override
  bool operator ==(Object other) =>
      identical(other, this) || (other is Category && other.id == id);

  @override
  int get hashCode => runtimeType.hashCode ^ id.hashCode;

  Category copyWith({CategoryName name}) {
    return Category(
      id: id,
      name: name ?? this.name,
    );
  }

  Category changeName(CategoryName newName) => copyWith(name: newName);
}
