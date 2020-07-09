import 'package:meta/meta.dart';
import 'package:collection/collection.dart';
import 'package:flutter_ddd/application/dto/note_summary_dto.dart';

@immutable
class NoteState {
  final List<NoteSummaryDto> _list;

  const NoteState({List<NoteSummaryDto> list}) : _list = list;

  List<NoteSummaryDto> get list =>
      _list == null ? null : List.unmodifiable(_list);

  @override
  bool operator ==(Object other) =>
      identical(other, this) ||
      (other is NoteState &&
          const ListEquality<NoteSummaryDto>().equals(other._list, _list));

  @override
  int get hashCode => runtimeType.hashCode ^ _list.hashCode;

  NoteState copyWith({List<NoteSummaryDto> list}) {
    return NoteState(
      list: list ?? _list,
    );
  }
}
