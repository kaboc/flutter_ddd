import 'package:meta/meta.dart';
import 'package:state_notifier/state_notifier.dart';
import 'package:flutter_ddd/application/note_app_service.dart';
import 'package:flutter_ddd/presentation/notifier/note_state.dart';

export 'package:flutter_ddd/application/dto/note_summary_dto.dart';
export 'package:flutter_ddd/presentation/notifier/note_state.dart';

class NoteNotifier extends StateNotifier<NoteState> {
  final NoteAppService _app;
  final String _categoryId;

  NoteNotifier({@required NoteAppService app, @required String categoryId})
      : _app = app,
        _categoryId = categoryId,
        super(const NoteState()) {
    _updateList();
  }

  Future<void> saveNote({
    @required String title,
    @required String body,
    @required String categoryId,
  }) async {
    await _app.saveNote(
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
    await _app.updateNote(
      id: id,
      title: title,
      body: body,
      categoryId: categoryId,
    );
    _updateList();
  }

  Future<void> removeNote(String id) async {
    await _app.removeNote(id);
    _updateList();
  }

  Future<NoteDto> getNote(String id) async {
    return await _app.getNote(id);
  }

  void _updateList() {
    _app.getNoteList(_categoryId).then((list) {
      state = state.copyWith(list: list);
    });
  }
}
