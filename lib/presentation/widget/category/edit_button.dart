import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_ddd/presentation/notifier/category_notifier.dart';
import 'package:flutter_ddd/presentation/widget/category/edit_dialog.dart';

class CategoryEditButton extends StatelessWidget {
  final CategoryDto category;

  const CategoryEditButton({@required this.category});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.edit),
      onPressed: () => CategoryEditDialog(
        context: context,
        heading: 'Edit category',
        buttonLabel: 'SAVE',
        initialName: category.name,
        onSave: ({name}) async {
          final notifier =
              Provider.of<CategoryNotifier>(context, listen: false);
          await notifier.updateCategory(
            id: category.id,
            name: name,
          );
        },
      ).show(),
    );
  }
}
