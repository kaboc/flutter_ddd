import 'package:flutter/material.dart';
import 'package:flutter_ddd/infrastructure/db_helper.dart';
import 'package:flutter_ddd/presentation/page/category_list.dart';

class AppInit {
  final GlobalKey<NavigatorState> navigatorKey;

  AppInit({
    @required this.navigatorKey,
    @required DbHelper dbHelper,
  }) {
    dbHelper.open().then((_) {
      navigatorKey.currentState.pushAndRemoveUntil<void>(
        MaterialPageRoute<dynamic>(
          builder: (_) => const CategoryListPage(),
        ),
        (_) => false,
      );
    });
  }
}
