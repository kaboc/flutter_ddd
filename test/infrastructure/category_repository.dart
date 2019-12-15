import 'package:flutter_ddd/domain/category/category.dart';
import 'package:flutter_ddd/domain/category/category_repository_base.dart';

export 'package:flutter_ddd/domain/category/category_repository_base.dart';

class CategoryRepository implements CategoryRepositoryBase {
  final _data = <CategoryId, Category>{};

  @override
  Future<T> transaction<T>(Future<T> Function() f) {
    return f();
  }

  @override
  Future<Category> find(CategoryId id) {
    final category = _data[id];

    if (category == null) {
      return null;
    }

    final clonedNote = Category(
      id: category.id,
      name: category.name,
    );

    return Future.value(clonedNote);
  }

  @override
  Future<Category> findByName(CategoryName name) {
    final category = _data.values.firstWhere(
      (category) => category.name == name,
      orElse: () => null,
    );

    if (category == null) {
      return null;
    }

    final clonedNote = Category(
      id: category.id,
      name: category.name,
    );

    return Future.value(clonedNote);
  }

  @override
  Future<List<Category>> findAll() {
    final clonedNotes = List<Category>.unmodifiable(_data.values);
    return Future.value(clonedNotes);
  }

  @override
  Future<void> save(Category category) {
    _data[category.id] = category;
    return null;
  }

  @override
  Future<void> remove(Category category) {
    _data.remove(category.id);
    return null;
  }

  void clear() {
    _data.clear();
  }
}
