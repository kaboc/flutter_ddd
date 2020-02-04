import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_ddd/common/exception.dart';
import 'package:flutter_ddd/presentation/model/category_model.dart';
import 'package:flutter_ddd/presentation/widget/error_dialog.dart';

class CategoryRemoveDialog extends StatelessWidget {
  final BuildContext _context;
  final CategoryDto category;

  const CategoryRemoveDialog({
    @required BuildContext context,
    @required this.category,
  }) : _context = context;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Remove category'),
      content: const Text('Are you sure you want to remove this category?'),
      actions: <Widget>[
        FlatButton(
          child: const Text('CANCEL'),
          onPressed: () => Navigator.pop(context),
        ),
        FlatButton(
          child: const Text('REMOVE'),
          onPressed: () async {
            try {
              final model = Provider.of<CategoryModel>(_context, listen: false);
              await model.removeCategory(category.id);
              Navigator.pop(context);
            } catch (e) {
              Navigator.pop(context);
              ErrorDialog(
                context: _context,
                message: (e as GenericException).message,
              ).show();
            }
          },
        ),
      ],
    );
  }

  void show() {
    showDialog<void>(
      context: _context,
      builder: build,
    );
  }
}
