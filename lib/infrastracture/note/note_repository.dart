import 'package:flutter_ddd/domain/note/note_repository_base.dart';
import 'package:flutter_ddd/infrastracture/db_helper.dart';

export 'package:flutter_ddd/infrastracture/db_helper.dart';

class NoteRepository implements NoteRepositoryBase {
  static NoteRepository _instance;
  static DbHelper _dbHelper;
  String test;

  factory NoteRepository(DbHelper dbHelper) {
    _instance ??= NoteRepository._();
    _dbHelper = dbHelper;
    return _instance;
  }

  NoteRepository._();

  Note toNote(Map<String, dynamic> data) {
    final String id = data['id'];
    final String title = data['title'];
    final String body = data['body'];
    final String categoryId = data['category_id'];

    return Note(
      id: NoteId(id),
      title: NoteTitle(title),
      body: NoteBody(body),
      categoryId: categoryId == null || categoryId.isEmpty
          ? null
          : CategoryId(categoryId),
    );
  }

  @override
  Future<Note> find(NoteId id) async {
    final db = await _dbHelper.db;
    final list = await db.rawQuery(
      'SELECT * FROM notes WHERE id = ?',
      [id.value],
    );

    return list.isEmpty ? null : toNote(list[0]);
  }

  @override
  Future<Note> findByTitle(NoteTitle title) async {
    final db = await _dbHelper.db;
    final list = await db.rawQuery(
      'SELECT * FROM notes WHERE title = ?',
      [title.value],
    );

    return list.isEmpty ? null : toNote(list[0]);
  }

  @override
  Future<List<Note>> findByCategory(CategoryId categoryId) async {
    final db = await _dbHelper.db;
    final list = await db.rawQuery(
      'SELECT * FROM notes WHERE category_id = ? ORDER BY title',
      [categoryId.value],
    );

    if (list.isEmpty) {
      return <Note>[];
    }

    return list.map((data) => toNote(data)).toList();
  }

  @override
  Future<int> countByCategory(CategoryId categoryId) async {
    final db = await _dbHelper.db;
    final list = await db.rawQuery(
      'SELECT COUNT(*) AS cnt FROM notes WHERE category_id = ?',
      [categoryId.value],
    );

    return list[0]['cnt'];
  }

  @override
  Future<void> save(Note note) async {
    final db = await _dbHelper.db;
    await db.rawInsert(
      '''
        INSERT OR REPLACE INTO notes
        (id, title, body, category_id) VALUES (?, ?, ?, ?)
      ''',
      [
        note.id.value,
        note.title.value,
        note.body.value,
        note.categoryId?.value,
      ],
    );
  }

  @override
  Future<void> remove(Note note) async {
    final db = await _dbHelper.db;
    await db.rawDelete('DELETE FROM notes WHERE id = ?', [note.id.value]);
  }
}
