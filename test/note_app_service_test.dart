import 'package:test/test.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_ddd/application/note_app_service.dart';
import 'package:flutter_ddd/infrastructure/note/note_factory.dart';
import 'infrastructure/note_repository.dart';

void main() {
  final repository = NoteRepository();

  GetIt.instance.registerSingleton<NoteRepositoryBase>(repository);

  group('Note', () {
    test('registering existing title should fail', () async {
      repository.clear();

      final app = NoteAppService(factory: const NoteFactory());
      await app.saveNote(
        title: 'note title',
        body: 'note body',
        categoryId: 'category id',
      );

      bool isSuccessful = true;

      try {
        await app.saveNote(
          title: 'note title',
          body: 'note body 2',
          categoryId: 'category id 2',
        );
      } catch (e) {
        if (e.toString().contains('already exists')) {
          isSuccessful = false;
        }
      }

      expect(isSuccessful, false);
    });

    test('new note should be registered', () async {
      repository.clear();

      final app = NoteAppService(factory: const NoteFactory());
      await app.saveNote(
        title: 'note title',
        body: 'note body',
        categoryId: 'category id',
      );

      final notes = await app.getNoteList('category id');
      expect(notes.length, 1);
    });

    test('update without change in title should be successful', () async {
      repository.clear();

      final app = NoteAppService(factory: const NoteFactory());
      await app.saveNote(
        title: 'note title',
        body: 'note body',
        categoryId: 'category id',
      );

      final notes = await app.getNoteList('category id');

      bool isSuccessful = true;

      try {
        await app.updateNote(
          id: notes[0].id,
          title: 'note title',
          body: 'note body 2',
          categoryId: 'category id',
        );
      } catch (_) {
        isSuccessful = false;
      }

      expect(isSuccessful, true);
    });

    test('note should be moved to another category', () async {
      repository.clear();

      final app = NoteAppService(factory: const NoteFactory());
      await app.saveNote(
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
      repository.clear();

      final app = NoteAppService(factory: const NoteFactory());
      await app.saveNote(
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
