import 'package:get_it/get_it.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_ddd/infrastructure/category/category_repository.dart';
import 'package:flutter_ddd/infrastructure/db_helper.dart';
import 'package:flutter_ddd/infrastructure/note/note_repository.dart';
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
        create: (_) {
          final helper = DbHelper();

          final getIt = GetIt.instance;
          getIt.registerSingleton<CategoryRepositoryBase>(
            CategoryRepository(dbHelper: helper),
          );
          getIt.registerSingleton<NoteRepositoryBase>(
            NoteRepository(dbHelper: helper),
          );

          return helper;
        },
        dispose: (_, helper) => helper.close(),
        child: const CategoryListPage(),
      ),
    );
  }
}
