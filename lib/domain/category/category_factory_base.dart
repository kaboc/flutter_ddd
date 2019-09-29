import 'package:flutter_ddd/domain/category/category.dart';

export 'package:flutter_ddd/domain/category/category.dart';

abstract class CategoryFactoryBase {
  Category create(String name);
}
