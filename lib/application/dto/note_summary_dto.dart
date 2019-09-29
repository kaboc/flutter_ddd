import 'package:flutter_ddd/domain/note/note.dart';

class NoteSummaryDto {
  final String id;
  final String title;

  NoteSummaryDto(Note source)
      : id = source.id.value,
        title = source.title.value;
}
