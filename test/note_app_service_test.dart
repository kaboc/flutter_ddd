import 'package:test/test.dart';
import 'package:flutter_ddd/application/note_app_service.dart';
import 'package:flutter_ddd/infrastracture/note/note_factory.dart';
import 'infrastracture/note_repository.dart';

void main() {
  group('Note', () {
    test('registering existing title should fail', () async {
      final app = NoteAppService(
        factory: NoteFactory(),
        repository: NoteRepository(),
      );

      bool isFailed = false;

      await app.registerNote(
        title: 'note title',
        body: 'note body',
        categoryId: 'category id',
      );

      try {
        await app.registerNote(
          title: 'note title',
          body: 'note body 2',
          categoryId: 'category id 2',
        );
      } catch (e) {
        if (e.toString().contains('already exists')) {
          isFailed = true;
        }
      }

      expect(isFailed, true);
    });

    test('new note should be registered', () async {
      final app = NoteAppService(
        factory: NoteFactory(),
        repository: NoteRepository(),
      );

      await app.registerNote(
        title: 'note title',
        body: 'note body',
        categoryId: 'category id',
      );

      final notes = await app.getNoteList('category id');
      expect(notes.length, 1);
    });

    test('update without change in title should be successful', () async {
      final app = NoteAppService(
        factory: NoteFactory(),
        repository: NoteRepository(),
      );

      bool isSuccessful = true;

      await app.registerNote(
        title: 'note title',
        body: 'note body',
        categoryId: 'category id',
      );

      final notes = await app.getNoteList('category id');

      try {
        await app.updateNote(
          id: notes[0].id,
          title: 'note title',
          body: 'note body 2',
          categoryId: 'category id',
        );
      } catch (e) {
        isSuccessful = false;
      }

      expect(isSuccessful, true);
    });

    test('note should be moved to another category', () async {
      final app = NoteAppService(
        factory: NoteFactory(),
        repository: NoteRepository(),
      );

      await app.registerNote(
        title: 'note title',
        body: 'note body',
        categoryId: 'category id 1',
      );

      List<NoteSummaryDto> notes = await app.getNoteList('category id 1');
      expect(notes.length, 1);

      await app.updateNote(
        id: notes[0].id,
        title: 'note title',
        body: 'note body',
        categoryId: 'category id 2',
      );

      notes = await app.getNoteList('category id 1');
      expect(notes.length, 0);

      notes = await app.getNoteList('category id 2');
      expect(notes.length, 1);
    });

    test('note should be removed', () async {
      final app = NoteAppService(
        factory: NoteFactory(),
        repository: NoteRepository(),
      );

      await app.registerNote(
        title: 'note title',
        body: 'note body',
        categoryId: 'category id',
      );

      final notes = await app.getNoteList('category id');
      await app.removeNote(notes[0].id);

      final note = await app.getNote(notes[0].id);
      expect(note, isNull);
    });
  });
}
