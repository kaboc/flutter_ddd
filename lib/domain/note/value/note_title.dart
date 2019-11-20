import 'package:meta/meta.dart' show immutable;
import 'package:flutter_ddd/common/exception.dart';

@immutable
class NoteTitle {
  final String value;

  NoteTitle(this.value)
      : assert(value != null),
        assert(value.isNotEmpty) {
    if (value == null || value.isEmpty) {
      throw NullEmptyException('Note title');
    }
    if (value.length > 50) {
      throw GenericException('Title must be 50 letters or shorter.');
    }
  }

  @override
  bool operator ==(Object other) =>
      identical(other, this) || (other is NoteTitle && other.value == value);

  @override
  int get hashCode => value.hashCode;
}
