import 'package:uuid/uuid.dart';
import 'package:flutter_ddd/domain/note/note_factory_base.dart';

class NoteFactory implements NoteFactoryBase {
  @override
  Note create(NoteTitle title, NoteBody body, CategoryId categoryId) {
    return Note(
      id: NoteId(Uuid().v4()),
      title: title,
      body: body,
      categoryId: categoryId,
    );
  }
}
