import 'package:meta/meta.dart';
import 'package:flutter_ddd/domain/category/category_repository_base.dart';
import 'package:flutter_ddd/infrastructure/db_helper.dart';

export 'package:flutter_ddd/domain/category/category_repository_base.dart';

class CategoryRepository implements CategoryRepositoryBase {
  final DbHelper _dbHelper;

  const CategoryRepository({@required DbHelper dbHelper}) : _dbHelper = dbHelper;

  Category toCategory(Map<String, dynamic> data) {
    final id = data['id'].toString();
    final name = data['name'].toString();

    return Category(
      id: CategoryId(id),
      name: CategoryName(name),
    );
  }

  @override
  Future<T> transaction<T>(Future<T> Function() f) async {
    return await _dbHelper.transaction<T>(() async => await f());
  }

  @override
  Future<Category> find(CategoryId id) async {
    final list = await _dbHelper.rawQuery(
      'SELECT * FROM categories WHERE id = ?',
      <String>[id.value],
    );

    return list.isEmpty ? null : toCategory(list[0]);
  }

  @override
  Future<Category> findByName(CategoryName name) async {
    final list = await _dbHelper.rawQuery(
      'SELECT * FROM categories WHERE name = ?',
      <String>[name.value],
    );

    return list.isEmpty ? null : toCategory(list[0]);
  }

  @override
  Future<List<Category>> findAll() async {
    final list = await _dbHelper.rawQuery(
      'SELECT * FROM categories ORDER BY name',
    );

    if (list.isEmpty) {
      return <Category>[];
    }

    return list.map((data) => toCategory(data)).toList();
  }

  @override
  Future<void> save(Category category) async {
    await _dbHelper.rawInsert(
      'INSERT OR REPLACE INTO categories (id, name) VALUES (?, ?)',
      <String>[category.id.value, category.name.value],
    );
  }

  @override
  Future<void> remove(Category category) async {
    await _dbHelper.rawDelete(
      'DELETE FROM categories WHERE id = ?',
      <String>[category.id.value],
    );
  }
}
