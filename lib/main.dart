import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_ddd/application/category_app_service.dart';
import 'package:flutter_ddd/infrastructure/category/category_factory.dart';
import 'package:flutter_ddd/infrastructure/category/category_repository.dart';
import 'package:flutter_ddd/infrastructure/db_helper.dart';
import 'package:flutter_ddd/infrastructure/note/note_repository.dart';
import 'package:flutter_ddd/init.dart';
import 'package:flutter_ddd/presentation/notifier/category_notifier.dart';
import 'package:flutter_ddd/presentation/page/init.dart';

const appTitle = 'Notes';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<DbHelper>(
          create: (_) => DbHelper(),
          dispose: (_, helper) async => await helper.dispose(),
        ),
        Provider<CategoryRepositoryBase>(
          create: (context) => CategoryRepository(
            dbHelper: context.read<DbHelper>(),
          ),
        ),
        Provider<NoteRepositoryBase>(
          create: (context) => NoteRepository(
            dbHelper: context.read<DbHelper>(),
          ),
        ),
        ChangeNotifierProvider<CategoryNotifier>(
          create: (context) => CategoryNotifier(
            app: CategoryAppService(
              factory: const CategoryFactory(),
              repository: context.read<CategoryRepositoryBase>(),
              noteRepository: context.read<NoteRepositoryBase>(),
            ),
          ),
        ),
        Provider<AppInit>(
          create: (context) => AppInit(
            navigatorKey: GlobalKey<NavigatorState>(),
            dbHelper: context.read<DbHelper>(),
          ),
        ),
      ],
      child: const _Init(),
    );
  }
}

class _Init extends StatelessWidget {
  const _Init();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle,
      theme: ThemeData(primarySwatch: Colors.green),
      navigatorKey: Provider.of<AppInit>(context).navigatorKey,
      onGenerateRoute: (_) {
        return MaterialPageRoute<dynamic>(
          builder: (_) => const InitPage(appTitle: appTitle),
        );
      },
    );
  }
}
