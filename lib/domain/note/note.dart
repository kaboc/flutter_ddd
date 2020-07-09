import 'package:meta/meta.dart';
import 'package:flutter_ddd/domain/category/value/category_id.dart';
import 'package:flutter_ddd/domain/note/value/note_body.dart';
import 'package:flutter_ddd/domain/note/value/note_id.dart';
import 'package:flutter_ddd/domain/note/value/note_title.dart';

export 'package:flutter_ddd/domain/category/value/category_id.dart';
export 'package:flutter_ddd/domain/note/value/note_body.dart';
export 'package:flutter_ddd/domain/note/value/note_id.dart';
export 'package:flutter_ddd/domain/note/value/note_title.dart';

@immutable
class Note {
  final NoteId id;
  final NoteTitle title;
  final NoteBody body;
  final CategoryId categoryId;

  const Note({
    @required this.id,
    @required this.title,
    @required this.body,
    @required this.categoryId,
  });

  @override
  bool operator ==(Object other) =>
      identical(other, this) || (other is Note && other.id == id);

  @override
  int get hashCode => runtimeType.hashCode ^ id.hashCode;

  Note copyWith({NoteTitle title, NoteBody body, CategoryId categoryId}) {
    return Note(
      id: id,
      title: title ?? this.title,
      body: body ?? this.body,
      categoryId: categoryId ?? this.categoryId,
    );
  }

  Note changeTitle(NoteTitle newTitle) => copyWith(title: newTitle);

  Note changeBody(NoteBody newBody) => copyWith(body: newBody);

  Note changeCategory(CategoryId newCategoryId) =>
      copyWith(categoryId: newCategoryId);
}
