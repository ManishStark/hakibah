import 'package:flutter_riverpod/flutter_riverpod.dart';

class CategoriesProvider extends StateNotifier<dynamic> {
  CategoriesProvider() : super(null);
  void setCategories(result) {
    state = result;
  }
}

final categoriesProvider =
    StateNotifierProvider<CategoriesProvider, dynamic>((ref) {
  return CategoriesProvider();
});
