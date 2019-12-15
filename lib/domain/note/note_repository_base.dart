import 'package:flutter_ddd/domain/note/note.dart';

export 'package:flutter_ddd/domain/note/note.dart';

abstract class NoteRepositoryBase {
  Future<T> transaction<T>(Future<T> Function() f);
  Future<Note> find(NoteId id);
  Future<Note> findByTitle(NoteTitle title);
  Future<List<Note>> findByCategory(CategoryId categoryId);
  Future<int> countByCategory(CategoryId categoryId);
  Future<void> save(Note note);
  Future<void> remove(Note note);
}
