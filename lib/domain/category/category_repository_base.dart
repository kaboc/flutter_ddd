import 'package:flutter_ddd/domain/category/category.dart';

export 'package:flutter_ddd/domain/category/category.dart';

abstract class CategoryRepositoryBase {
  Future<T> transaction<T>(Future<T> Function() f);
  Future<Category> find(CategoryId id);
  Future<Category> findByName(CategoryName name);
  Future<List<Category>> findAll();
  Future<void> save(Category category);
  Future<void> remove(Category category);
}
