import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_ddd/presentation/notifier/category_notifier.dart';
import 'package:flutter_ddd/presentation/page/note_list.dart';
import 'package:flutter_ddd/presentation/widget/category/edit_button.dart';
import 'package:flutter_ddd/presentation/widget/category/remove_button.dart';

class CategoryListView extends StatelessWidget {
  const CategoryListView();

  @override
  Widget build(BuildContext context) {
    final notifier = Provider.of<CategoryNotifier>(context);

    if (notifier.list == null)
      return const Center(child: CircularProgressIndicator());
    else if (notifier.list.isEmpty)
      return const Center(
        child: Text(
          'No category yet',
          style: TextStyle(color: Colors.grey),
        ),
      );
    else
      return ListView.builder(
        itemCount: notifier.list.length,
        itemBuilder: (context, index) => _listTile(context, notifier, index),
      );
  }

  Widget _listTile(BuildContext context, CategoryNotifier notifier, int index) {
    final category = notifier.list[index];

    return Card(
      child: ListTile(
        leading: const IconTheme(
          data: IconThemeData(color: Colors.amber),
          child: Icon(Icons.folder),
        ),
        title: Text(category.name),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            CategoryEditButton(category: category),
            CategoryRemoveButton(categoryId: category.id),
          ],
        ),
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute<void>(
            builder: (_) => ChangeNotifierProvider<CategoryNotifier>.value(
              value: notifier,
              child: NoteListPage(category: category),
            ),
          ),
        ),
      ),
    );
  }
}
