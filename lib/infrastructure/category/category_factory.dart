import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_ddd/domain/category/category_factory_base.dart';

class CategoryFactory implements CategoryFactoryBase {
  const CategoryFactory();

  @override
  Category create({@required String name}) {
    return Category(
      id: CategoryId(Uuid().v4()),
      name: CategoryName(name),
    );
  }
}
