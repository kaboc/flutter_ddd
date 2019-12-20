import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_ddd/presentation/model/category_model.dart';
import 'package:flutter_ddd/presentation/page/note_list.dart';
import 'package:flutter_ddd/presentation/widget/category/edit_button.dart';
import 'package:flutter_ddd/presentation/widget/category/remove_button.dart';

class CategoryListView extends StatelessWidget {
  const CategoryListView();

  @override
  Widget build(BuildContext context) {
    final models = Provider.of<CategoryModel>(context);

    if (models.list == null)
      return const Center(child: CircularProgressIndicator());
    else if (models.list.isEmpty)
      return const Center(
        child: Text(
          'No category yet',
          style: TextStyle(color: Colors.grey),
        ),
      );
    else
      return ListView.builder(
        itemCount: models.list.length,
        itemBuilder: (context, index) => _listTile(context, models, index),
      );
  }

  Widget _listTile(BuildContext context, CategoryModel models, int index) {
    final category = models.list[index];

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
            CategoryRemoveButton(category: category),
          ],
        ),
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute<void>(
            builder: (_) => ChangeNotifierProvider<CategoryModel>.value(
              value: models,
              child: NoteListPage(category: category),
            ),
          ),
        ),
      ),
    );
  }
}
