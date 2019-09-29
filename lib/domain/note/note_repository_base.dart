import 'package:flutter_ddd/domain/note/note.dart';

export 'package:flutter_ddd/domain/note/note.dart';

abstract class NoteRepositoryBase {
  Future<Note> find(NoteId id);
  Future<Note> findByTitle(NoteTitle title);  // TODO: Dartにはメソッドのオーバーロードがないので別名に。
  Future<List<Note>> findByCategory(CategoryId categoryId); // TODO: bodyを含めずに取得するメソッドがあったほうがいいか？
  Future<int> countByCategory(CategoryId categoryId);
  Future<void> save(Note note);
  Future<void> remove(Note note);
}
