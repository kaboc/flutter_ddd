import 'package:meta/meta.dart';

import 'package:flutter_ddd/domain/note/note.dart';

@immutable
class NoteSummaryDto {
  final String id;
  final String title;

  NoteSummaryDto(Note source)
      : id = source.id.value,
        title = source.title.value;

  @override
  bool operator ==(Object other) =>
      identical(other, this) ||
      (other is NoteSummaryDto && other.id == id && other.title == title);

  @override
  int get hashCode => runtimeType.hashCode ^ id.hashCode ^ title.hashCode;
}
