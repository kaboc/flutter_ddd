import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_ddd/infrastracture/db_helper.dart';
import 'package:flutter_ddd/presentation/page/category_list.dart';

void main() => runApp(MyApp());


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: Provider<DbHelper>(
        builder: (_) => DbHelper(),
        dispose: (_, dbHelper) => dbHelper.close(),
        child: const CategoryListPage(),
      ),
    );
  }
}
