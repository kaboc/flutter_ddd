import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_ddd/common/exception.dart';
import 'package:flutter_ddd/presentation/model/category_model.dart';
import 'package:flutter_ddd/presentation/widget/error_dialog.dart';
import 'package:flutter_ddd/presentation/widget/note/dropdown.dart';

export 'package:flutter_ddd/presentation/model/category_model.dart';

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
        _titleController =
            Provider.of<TitleEditingController>(context, listen: false)
              ..text = initialTitle ?? '',
        _bodyController =
            Provider.of<BodyEditingController>(context, listen: false)
              ..text = initialBody ?? '';

  @override
  Widget build(BuildContext context) {
    final categoryModel = Provider.of<CategoryModel>(_context, listen: false);
    CategoryDto selectedCategory = category;

    return Center(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: AlertDialog(
          title: Text(heading),
          content: Column(
            children: <Widget>[
              CategoryDropdown(
                list: categoryModel.list,
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
              onPressed: () => Navigator.pop(context),
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
      Navigator.pop(context);
    } catch (e) {
      Navigator.pop(context);
      ErrorDialog(
        context: _context,
        message: (e as GenericException).message,
        onConfirm: show,
      ).show();
    }
  }
}
