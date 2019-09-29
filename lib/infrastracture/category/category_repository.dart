import 'package:flutter_ddd/domain/category/category_repository_base.dart';
import 'package:flutter_ddd/infrastracture/db_helper.dart';

export 'package:flutter_ddd/infrastracture/db_helper.dart';

class CategoryRepository implements CategoryRepositoryBase {
  static CategoryRepository _instance;
  static DbHelper _dbHelper;

  factory CategoryRepository(DbHelper dbHelper) {
    _instance ??= CategoryRepository._();
    _dbHelper = dbHelper;
    return _instance;
  }

  CategoryRepository._();

  Category toCategory(Map<String, dynamic> data) {
    final String id = data['id'];
    final String name = data['name'];

    return Category(
      id: CategoryId(id),
      name: CategoryName(name),
    );
  }

  @override
  Future<Category> find(CategoryId id) async {
    final db = await _dbHelper.db;
    final list = await db.rawQuery(
      'SELECT * FROM categories WHERE id = ?',
      [id.value],
    );

    return list.isEmpty ? null : toCategory(list[0]);
  }

  @override
  Future<Category> findByName(CategoryName name) async {
    final db = await _dbHelper.db;
    final list = await db.rawQuery(
      'SELECT * FROM categories WHERE name = ?',
      [name.value],
    );

    return list.isEmpty ? null : toCategory(list[0]);
  }

  @override
  Future<List<Category>> findAll() async {
    final db = await _dbHelper.db;
    final list = await db.rawQuery('SELECT * FROM categories ORDER BY name');

    if (list.isEmpty) {
      return <Category>[];
    }

    return list.map((data) => toCategory(data)).toList();
  }

  @override
  Future<void> save(Category category) async {
    final db = await _dbHelper.db;
    await db.rawInsert(
      'INSERT OR REPLACE INTO categories (id, name) VALUES (?, ?)',
      [category.id.value, category.name.value],
    );
  }

  @override
  Future<void> remove(Category category) async {
    final db = await _dbHelper.db;
    await db.rawDelete(
      'DELETE FROM categories WHERE id = ?',
      [category.id.value],
    );
  }
}
