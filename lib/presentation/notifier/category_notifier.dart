import 'package:meta/meta.dart';
import 'package:state_notifier/state_notifier.dart';
import 'package:flutter_ddd/application/category_app_service.dart';
import 'package:flutter_ddd/presentation/notifier/category_state.dart';

export 'package:flutter_ddd/application/dto/category_dto.dart';
export 'package:flutter_ddd/presentation/notifier/category_state.dart';

class CategoryNotifier extends StateNotifier<CategoryState> {
  final CategoryAppService _app;

  CategoryNotifier({@required CategoryAppService app})
      : _app = app,
        super(const CategoryState()) {
    _updateList();
  }

  Future<void> saveCategory({
    @required String name,
  }) async {
    await _app.saveCategory(name: name);
    _updateList();
  }

  Future<void> updateCategory({
    @required String id,
    @required String name,
  }) async {
    await _app.updateCategory(id: id, name: name);
    _updateList();
  }

  Future<void> removeCategory(String id) async {
    await _app.removeCategory(id);
    _updateList();
  }

  void _updateList() {
    _app.getCategoryList().then((list) {
      state = state.copyWith(list: list);
    });
  }
}
