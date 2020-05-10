import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_ddd/presentation/notifier/category_notifier.dart';
import 'package:flutter_ddd/presentation/widget/category/edit_dialog.dart';

class CategoryAddButton extends StatelessWidget {
  const CategoryAddButton();

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: const Icon(Icons.add),
      onPressed: () => CategoryEditDialog(
        context: context,
        heading: 'New category',
        buttonLabel: 'SAVE',
        onSave: ({name}) async {
          await context.read<CategoryNotifier>().saveCategory(name: name);
        },
      ).show(),
    );
  }
}
