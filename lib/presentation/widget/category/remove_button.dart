import 'package:flutter/material.dart';
import 'package:flutter_ddd/presentation/model/category_model.dart';
import 'package:flutter_ddd/presentation/widget/category/remove_dialog.dart';

class CategoryRemoveButton extends StatelessWidget {
  final CategoryDto category;

  const CategoryRemoveButton({@required this.category});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.delete),
      onPressed: () => CategoryRemoveDialog(
        context: context,
        category: category
      ).show(),
    );
  }
}
