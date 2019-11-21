import 'package:meta/meta.dart';
import 'package:flutter_ddd/domain/category/category.dart';

export 'package:flutter_ddd/domain/category/category.dart';

abstract class CategoryFactoryBase {
  Category create({@required String name});
}
