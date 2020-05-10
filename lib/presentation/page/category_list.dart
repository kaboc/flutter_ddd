import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_ddd/presentation/widget/category/add_button.dart';
import 'package:flutter_ddd/presentation/widget/category/category_list_view.dart';

class CategoryListPage extends StatelessWidget {
  const CategoryListPage();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TextEditingController>(
      create: (_) => TextEditingController(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Categories')),
        body: const CategoryListView(),
        floatingActionButton: const CategoryAddButton(),
      ),
    );
  }
}
