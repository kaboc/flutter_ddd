import 'package:flutter_ddd/domain/note/note.dart';

export 'package:flutter_ddd/domain/note/note.dart';

abstract class NoteFactoryBase {
  Note create(NoteTitle title, NoteBody body, CategoryId categoryId);
}
