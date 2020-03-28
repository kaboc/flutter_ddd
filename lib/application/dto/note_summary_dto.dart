import 'package:meta/meta.dart';

import 'package:flutter_ddd/domain/note/note.dart';

@immutable
class NoteSummaryDto {
  final String id;
  final String title;

  NoteSummaryDto(Note source)
      : id = source.id.value,
        title = source.title.value;
}
