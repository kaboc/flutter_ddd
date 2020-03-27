import 'package:meta/meta.dart';

import 'package:flutter_ddd/domain/note/note.dart';

@immutable
class NoteDto {
  final String id;
  final String title;
  final String body;
  final String categoryId;

  NoteDto(Note source)
      : id = source.id.value,
        title = source.title.value,
        body = source.body.value,
        categoryId = source.categoryId.value;
}
