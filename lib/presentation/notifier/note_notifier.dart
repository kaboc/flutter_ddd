import 'package:flutter/foundation.dart';
import 'package:flutter_ddd/app_service/note_app_service.dart';

export 'package:flutter_ddd/app_service/dto/note_summary_dto.dart';

class NoteNotifier with ChangeNotifier {
  final NoteAppService _service;
  final String _categoryId;

  NoteNotifier({@required NoteAppService service, @required String categoryId})
      : _service = service,
        _categoryId = categoryId {
    _updateList();
  }

  List<NoteSummaryDto> _list;

  List<NoteSummaryDto> get list =>
      _list == null ? null : List.unmodifiable(_list);

  Future<void> saveNote({
    @required String title,
    @required String body,
    @required String categoryId,
  }) async {
    await _service.saveNote(
      title: title,
      body: body,
      categoryId: categoryId,
    );
    _updateList();
  }

  Future<void> updateNote({
    @required String id,
    @required String title,
    @required String body,
    @required String categoryId,
  }) async {
    await _service.updateNote(
      id: id,
      title: title,
      body: body,
      categoryId: categoryId,
    );
    _updateList();
  }

  Future<void> removeNote(String id) async {
    await _service.removeNote(id);
    _updateList();
  }

  Future<NoteDto> getNote(String id) async {
    return await _service.getNote(id);
  }

  void _updateList() {
    _service.getNoteList(_categoryId).then((list) {
      _list = list;
      notifyListeners();
    });
  }
}
