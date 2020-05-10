import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_ddd/common/exception.dart';
import 'package:flutter_ddd/presentation/notifier/category_notifier.dart';
import 'package:flutter_ddd/presentation/widget/error_dialog.dart';
import 'package:flutter_ddd/presentation/widget/note/dropdown.dart';

export 'package:flutter_ddd/presentation/notifier/category_notifier.dart';

typedef SaveCallback = Future<void> Function({
  @required String title,
  @required String body,
  @required String categoryId,
});

class TitleEditingController = TextEditingController with Type;
class BodyEditingController = TextEditingController with Type;

class NoteEditDialog extends StatelessWidget {
  final BuildContext _context;
  final String heading;
  final String buttonLabel;
  final SaveCallback onSave;
  final CategoryDto category;
  final TitleEditingController _titleController;
  final BodyEditingController _bodyController;

  NoteEditDialog({
    @required BuildContext context,
    @required this.heading,
    @required this.buttonLabel,
    @required this.onSave,
    @required this.category,
    String initialTitle,
    String initialBody,
  })  : _context = context,
        _titleController = context.read<TitleEditingController>()
          ..text = initialTitle ?? '',
        _bodyController = context.read<BodyEditingController>()
          ..text = initialBody ?? '';

  @override
  Widget build(BuildContext context) {
    final categoryNotifier =
        Provider.of<CategoryNotifier>(_context, listen: false);
    CategoryDto selectedCategory = category;

    return Center(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: AlertDialog(
          title: Text(heading),
          content: Column(
            children: <Widget>[
              CategoryDropdown(
                list: categoryNotifier.list,
                value: selectedCategory,
                onChanged: (category) => selectedCategory = category,
              ),
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Title',
                  hintText: 'Enter note title',
                ),
              ),
              TextField(
                controller: _bodyController,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                minLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Note',
                  hintText: 'Enter note',
                ),
              ),
            ],
          ),
          actions: <Widget>[
            FlatButton(
              child: const Text('CANCEL'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            FlatButton(
              child: Text(buttonLabel),
              onPressed: () async => _onPressed(context, selectedCategory),
            ),
          ],
        ),
      ),
    );
  }

  void show() {
    showDialog<void>(
      context: _context,
      builder: build,
    );
  }

  Future<void> _onPressed(BuildContext context, CategoryDto category) async {
    try {
      await onSave(
        title: _titleController.text,
        body: _bodyController.text,
        categoryId: category.id,
      );
      Navigator.of(context).pop();
    } on GenericException catch (e) {
      Navigator.of(context).pop();
      _showErrorDialog(e.message);
    } catch (_) {
      Navigator.of(context).pop();
      _showErrorDialog('Unknown error occurred.');
    }
  }

  void _showErrorDialog(String message) {
    ErrorDialog(
      context: _context,
      message: message,
      onConfirm: show,
    ).show();
  }
}
