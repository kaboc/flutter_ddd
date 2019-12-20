import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_ddd/presentation/model/category_model.dart';
import 'package:flutter_ddd/presentation/widget/error_dialog.dart';
import 'package:flutter_ddd/presentation/widget/note/dropdown.dart';

export 'package:flutter_ddd/presentation/model/category_model.dart';

class TitleEditingController = TextEditingController with Type;
class BodyEditingController = TextEditingController with Type;

class SelectedCategory {
  CategoryDto category;

  SelectedCategory(this.category);
}

typedef SaveCallback = Function({
  @required String title,
  @required String body,
  @required String categoryId,
});

class NoteEditDialog extends StatelessWidget {
  final BuildContext _context;
  final String heading;
  final String buttonLabel;
  final CategoryDto category;
  final SaveCallback onSave;
  final SelectedCategory _selected;
  final TitleEditingController _titleController;
  final BodyEditingController _bodyController;

  NoteEditDialog({
    @required BuildContext context,
    @required this.heading,
    @required this.buttonLabel,
    @required this.category,
    @required this.onSave,
    String initialTitle,
    String initialBody,
  })  : _context = context,
        _selected = SelectedCategory(category),
        _titleController =
            Provider.of<TitleEditingController>(context, listen: false)
              ..text = initialTitle ?? '',
        _bodyController =
            Provider.of<BodyEditingController>(context, listen: false)
              ..text = initialBody ?? '';

  @override
  Widget build(BuildContext context) {
    _selected.category = category ?? _selected.category;

    final categoryModel = Provider.of<CategoryModel>(_context, listen: false);

    return Center(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: AlertDialog(
          title: Text(heading),
          content: Column(
            children: <Widget>[
              CategoryDropdown(
                categories: categoryModel.list,
                selected: _selected,
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
              onPressed: () async => _onPressed(context),
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

  Future<void> _onPressed(BuildContext context) async {
    try {
      await onSave(
          title: _titleController.text,
          body: _bodyController.text,
          categoryId: _selected.category.id,
      );
      Navigator.pop(context);
    } catch (e) {
      Navigator.pop(context);
      ErrorDialog(
        context: _context,
        message: e.toString(),
        onConfirm: show,
      ).show();
    }
  }
}
