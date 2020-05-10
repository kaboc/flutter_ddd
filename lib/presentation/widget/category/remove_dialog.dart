import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_ddd/common/exception.dart';
import 'package:flutter_ddd/presentation/notifier/category_notifier.dart';
import 'package:flutter_ddd/presentation/widget/error_dialog.dart';

class CategoryRemoveDialog extends StatelessWidget {
  final BuildContext _context;
  final String categoryId;

  const CategoryRemoveDialog({
    @required BuildContext context,
    @required this.categoryId,
  }) : _context = context;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Remove category'),
      content: const Text('Are you sure you want to remove this category?'),
      actions: <Widget>[
        FlatButton(
          child: const Text('CANCEL'),
          onPressed: () => Navigator.of(context).pop(),
        ),
        FlatButton(
          child: const Text('REMOVE'),
          onPressed: () async {
            try {
              await _context
                  .read<CategoryNotifier>()
                  .removeCategory(categoryId);
              Navigator.of(context).pop();
            } on GenericException catch (e) {
              Navigator.of(context).pop();
              _showErrorDialog(e.message);
            } catch (_) {
              Navigator.of(context).pop();
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
