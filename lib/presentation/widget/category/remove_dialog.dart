import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_ddd/common/exception.dart';
import 'package:flutter_ddd/presentation/notifier/category_notifier.dart';
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
              final notifier =
                  Provider.of<CategoryNotifier>(_context, listen: false);
              await notifier.removeCategory(category.id);
              Navigator.pop(context);
            } on GenericException catch (e) {
              Navigator.pop(context);
              _showErrorDialog(e.message);
            } catch (_) {
              Navigator.pop(context);
              _showErrorDialog('Unknown error occurred.');
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

  void _showErrorDialog(String message) {
    ErrorDialog(
      context: _context,
      message: message,
    ).show();
  }
}
