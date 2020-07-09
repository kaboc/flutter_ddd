import 'package:meta/meta.dart';

import 'package:flutter_ddd/domain/category/category.dart';

@immutable
class CategoryDto {
  final String id;
  final String name;

  CategoryDto(Category source)
      : id = source.id.value,
        name = source.name.value;

  @override
  bool operator ==(Object other) =>
      identical(other, this) ||
      (other is CategoryDto && other.id == id && other.name == name);

  @override
  int get hashCode => runtimeType.hashCode ^ id.hashCode ^ name.hashCode;
}
