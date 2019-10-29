import 'package:uuid/uuid.dart';
import 'package:flutter_ddd/domain/category/category_factory_base.dart';

class CategoryFactory implements CategoryFactoryBase {
  @override
  Category create(String name) {
    return Category(
      id: CategoryId(Uuid().v4()),
      name: CategoryName(name),
    );
  }
}
