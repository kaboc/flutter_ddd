import 'package:meta/meta.dart';

import 'package:flutter_ddd/domain/category/category.dart';

@immutable
class CategoryDto {
  final String id;
  final String name;

  CategoryDto(Category source)
      : id = source.id.value,
        name = source.name.value;
}
