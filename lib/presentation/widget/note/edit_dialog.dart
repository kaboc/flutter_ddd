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

class EditDialog {
  final BuildContext context;
  final String heading;
  final String buttonLabel;
  final CategoryDto category;
  final SaveCallback onSave;
  final String initialTitle;
  final String initialBody;
  final SelectedCategory _selected;
  final TitleEditingController _titleController;
  final BodyEditingController _bodyController;

  EditDialog({
    @required this.context,
    @required this.heading,
    @required this.buttonLabel,
    @required this.category,
    @required this.onSave,
    this.initialTitle,
    this.initialBody,
  })  : _selected = SelectedCategory(category),
        _titleController =
            Provider.of<TitleEditingController>(context, listen: false)
              ..text = initialTitle ?? '',
        _bodyController =
            Provider.of<BodyEditingController>(context, listen: false)
              ..text = initialBody ?? '' {
    _showDialog();
  }

  Future<void> _showDialog() {
    _selected.category = category ?? _selected.category;

    final categoryModel = Provider.of<CategoryModel>(context, listen: false);

    return showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text(heading),
          content: SingleChildScrollView(
            child: Column(
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
                  minLines: 5,
                  decoration: const InputDecoration(
                    labelText: 'Note',
                    hintText: 'Enter note',
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: const Text('CANCEL'),
              onPressed: () => Navigator.pop(dialogContext),
            ),
            FlatButton(
              child: Text(buttonLabel),
              onPressed: () async {
                try {
                  await onSave(
                    title: _titleController.text,
                    body: _bodyController.text,
                    categoryId: _selected.category.id,
                  );
                  Navigator.pop(dialogContext);
                } catch (e) {
                  Navigator.pop(dialogContext);
                  ErrorDialog.show(
                    context: context,
                    message: e.toString(),
                    onOk: _showDialog,
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }
}
