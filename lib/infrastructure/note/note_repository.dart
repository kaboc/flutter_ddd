import 'package:meta/meta.dart';
import 'package:flutter_ddd/domain/note/note_repository_base.dart';
import 'package:flutter_ddd/infrastructure/db_helper.dart';

export 'package:flutter_ddd/domain/note/note_repository_base.dart';

class NoteRepository implements NoteRepositoryBase {
  final DbHelper _dbHelper;

  const NoteRepository({@required DbHelper dbHelper}) : _dbHelper = dbHelper;

  Note toNote(Map<String, dynamic> data) {
    final id = data['id'].toString();
    final title = data['title'].toString();
    final body = data['body'].toString();
    final categoryId = data['category_id'].toString();

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
  Future<T> transaction<T>(Future<T> Function() f) async {
    return await _dbHelper.transaction<T>(() async => await f());
  }

  @override
  Future<Note> find(NoteId id) async {
    final list = await _dbHelper.rawQuery(
      'SELECT * FROM notes WHERE id = ?',
      <String>[id.value],
    );

    return list.isEmpty ? null : toNote(list[0]);
  }

  @override
  Future<Note> findByTitle(NoteTitle title) async {
    final list = await _dbHelper.rawQuery(
      'SELECT * FROM notes WHERE title = ?',
      <String>[title.value],
    );

    return list.isEmpty ? null : toNote(list[0]);
  }

  @override
  Future<List<Note>> findByCategory(CategoryId categoryId) async {
    final list = await _dbHelper.rawQuery(
      'SELECT * FROM notes WHERE category_id = ? ORDER BY title',
      <String>[categoryId.value],
    );

    if (list.isEmpty) {
      return <Note>[];
    }

    return list.map((data) => toNote(data)).toList();
  }

  @override
  Future<int> countByCategory(CategoryId categoryId) async {
    final list = await _dbHelper.rawQuery(
      'SELECT COUNT(*) AS cnt FROM notes WHERE category_id = ?',
      <String>[categoryId.value],
    );

    final row = Map<String, int>.from(list[0]);
    return row['cnt'];
  }

  @override
  Future<void> save(Note note) async {
    await _dbHelper.rawInsert(
      '''
        INSERT OR REPLACE INTO notes
        (id, title, body, category_id) VALUES (?, ?, ?, ?)
      ''',
      <String>[
        note.id.value,
        note.title.value,
        note.body.value,
        note.categoryId?.value,
      ],
    );
  }

  @override
  Future<void> remove(Note note) async {
    await _dbHelper.rawDelete(
      'DELETE FROM notes WHERE id = ?',
      <String>[note.id.value],
    );
  }
}
