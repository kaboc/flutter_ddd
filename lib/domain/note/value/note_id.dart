import 'package:flutter_ddd/common/exception.dart';

class NoteId {
  final String value;

  NoteId(this.value)
      : assert(value != null),
        assert(value.isNotEmpty) {
    if (value == null || value.isEmpty) {
      throw NullEmptyException('Note ID');
    }
  }

  @override
  bool operator ==(Object other) =>
      identical(other, this) || (other is NoteId && other.value == value);

  @override
  int get hashCode => value.hashCode;
}
