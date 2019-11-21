import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_ddd/domain/note/note_factory_base.dart';

class NoteFactory implements NoteFactoryBase {
  const NoteFactory();

  @override
  Note create({
    @required NoteTitle title,
    @required NoteBody body,
    @required CategoryId categoryId,
  }) {
    return Note(
      id: NoteId(Uuid().v4()),
      title: title,
      body: body,
      categoryId: categoryId,
    );
  }
}
