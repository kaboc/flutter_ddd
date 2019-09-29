import 'package:meta/meta.dart' show required;
import 'package:flutter/material.dart';
import 'package:flutter_ddd/presentation/widget/note/edit_dialog.dart';

class CategoryDropdown extends StatefulWidget {
  final List<CategoryDto> categories;
  final SelectedCategory selected;

  const CategoryDropdown({
    @required this.categories,
    @required this.selected,
  });

  @override
  _CategoryDropdownState createState() => _CategoryDropdownState();
}

class _CategoryDropdownState extends State<CategoryDropdown> {
  @override
  Widget build(BuildContext context) {
    return InputDecorator(
      decoration: const InputDecoration(
        labelText: 'Category',
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<CategoryDto>(
          isExpanded: true,
          isDense: true,
          value: widget.selected.category,
          items: widget.categories
              .map(
                (category) => DropdownMenuItem<CategoryDto>(
                  value: category,
                  child: Text(category.name),
                ),
              )
              .toList(),
          onChanged: (category) {
            setState(() => widget.selected.category = category);
          },
        ),
      ),
    );
  }
}
