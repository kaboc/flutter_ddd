import 'package:test/test.dart';
import 'package:flutter_ddd/application/category_app_service.dart';
import 'package:flutter_ddd/infrastructure/category/category_factory.dart';
import 'infrastructure/category_repository.dart';
import 'infrastructure/note_repository.dart';

void main() {
  group('Category', () {
    test('registering existing name should fail', () async {
      final app = CategoryAppService(
        factory: CategoryFactory(),
        repository: CategoryRepository(),
        noteRepository: NoteRepository(),
      );

      bool isFailed = false;

      await app.registerCategory(name: 'category name');

      try {
        await app.registerCategory(name: 'category name');
      } catch (e) {
        if (e.toString().contains('already exists')) {
          isFailed = true;
        }
      }

      expect(isFailed, true);
    });

    test('new category should be registered', () async {
      final app = CategoryAppService(
        factory: CategoryFactory(),
        repository: CategoryRepository(),
        noteRepository: NoteRepository(),
      );

      await app.registerCategory(name: 'category name');

      final categories = await app.getCategoryList();
      expect(categories.length, 1);
    });

    test('update without change should be successful', () async {
      final app = CategoryAppService(
        factory: CategoryFactory(),
        repository: CategoryRepository(),
        noteRepository: NoteRepository(),
      );

      bool isSuccessful = true;

      await app.registerCategory(name: 'category name');

      final categories = await app.getCategoryList();

      try {
        await app.updateCategory(
          id: categories[0].id,
          name: 'category name',
        );
      } catch (e) {
        isSuccessful = false;
      }

      expect(isSuccessful, true);
    });

    test('category should be removed', () async {
      final app = CategoryAppService(
        factory: CategoryFactory(),
        repository: CategoryRepository(),
        noteRepository: NoteRepository(),
      );

      await app.registerCategory(name: 'category name');

      final categories = await app.getCategoryList();
      await app.removeCategory(categories[0].id);

      expect(await app.getCategoryList(), isEmpty);
    });
  });
}
