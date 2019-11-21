import 'package:meta/meta.dart';
import 'package:flutter_ddd/domain/note/note.dart';

export 'package:flutter_ddd/domain/note/note.dart';

abstract class NoteFactoryBase {
  Note create({
    @required NoteTitle title,
    @required NoteBody body,
    @required CategoryId categoryId,
  });
}
