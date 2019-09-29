import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_ddd/presentation/model/category_model.dart';
import 'package:flutter_ddd/presentation/widget/category/edit_dialog.dart';

class CategoryRegisterButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: const Icon(Icons.add),
      onPressed: () => EditDialog(
        context: context,
        heading: 'New category',
        buttonLabel: 'REGISTER',
        onSave: ({name}) async {
          final model = Provider.of<CategoryModel>(context, listen: false);
          await model.registerCategory(name: name);
        },
      ),
    );
  }
}
