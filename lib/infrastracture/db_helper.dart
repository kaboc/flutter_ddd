import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DbHelper {
  static const _DB_FILE = 'ddd.db';
  static const _DB_VERSION = 1;
  Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }

    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, _DB_FILE);

    _db = await openDatabase(
      path,
      version: _DB_VERSION,
      onCreate: (Database db, int version) async {
        await db.execute('''
          CREATE TABLE notes (
            id TEXT NOT NULL,
            title TEXT NOT NULL,
            body TEXT NOT NULL,
            category_id TEXT NOT NULL,
            PRIMARY KEY (id)
          )
        ''');

        await db.execute('''
          CREATE INDEX idx_category_id
          ON notes(category_id)
        ''');

        await db.execute('''
          CREATE TABLE categories (
            id TEXT NOT NULL,
            name TEXT NOT NULL,
            PRIMARY KEY (id)
          )
        ''');
      },
    );

    return _db;
  }

  Future<void> close() async {
    await _db?.close();
    _db = null;
  }
}
