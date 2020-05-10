import 'package:flutter/material.dart';
import 'package:flutter_ddd/presentation/widget/category/remove_dialog.dart';

class CategoryRemoveButton extends StatelessWidget {
  final String categoryId;

  const CategoryRemoveButton({@required this.categoryId});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.delete),
      onPressed: () => CategoryRemoveDialog(
        context: context,
        categoryId: categoryId,
      ).show(),
    );
  }
}
