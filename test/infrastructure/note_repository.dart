import 'package:flutter_ddd/domain/note/note.dart';
import 'package:flutter_ddd/domain/note/note_repository_base.dart';

export 'package:flutter_ddd/domain/note/note_repository_base.dart';

class NoteRepository implements NoteRepositoryBase {
  final _data = <NoteId, Note>{};

  @override
  Future<T> transaction<T>(Function f) {
    return f();
  }

  @override
  Future<Note> find(NoteId id) {
    final note = _data[id];

    if (note == null) {
      return null;
    }

    final clonedNote = Note(
      id: note.id,
      title: note.title,
      body: note.body,
      categoryId: note.categoryId,
    );

    return Future.value(clonedNote);
  }

  @override
  Future<Note> findByTitle(NoteTitle title) {
    final note = _data.values.firstWhere(
      (note) => note.title == title,
      orElse: () => null,
    );

    if (note == null) {
      return null;
    }

    final clonedNote = Note(
      id: note.id,
      title: note.title,
      body: note.body,
      categoryId: note.categoryId,
    );

    return Future.value(clonedNote);
  }

  @override
  Future<List<Note>> findByCategory(CategoryId categoryId) {
    final clonedNotes = _data.values
        .where((note) => note.categoryId == categoryId)
        .map((note) => Note(
              id: note.id,
              title: note.title,
              body: note.body,
              categoryId: categoryId,
            ))
        .toList();

    return Future.value(clonedNotes);
  }

  @override
  Future<int> countByCategory(CategoryId categoryId) {
    final count =
        _data.values.where((note) => note.categoryId == categoryId).length;

    return Future.value(count);
  }

  @override
  Future<void> save(Note note) {
    _data[note.id] = note;
    return null;
  }

  @override
  Future<void> remove(Note note) {
    _data.remove(note.id);
    return null;
  }

  void clear() {
    _data.clear();
  }
}
