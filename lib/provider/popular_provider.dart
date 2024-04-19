import 'package:flutter_riverpod/flutter_riverpod.dart';

class PopularProvider extends StateNotifier<dynamic> {
  PopularProvider() : super(null);
  void setPopular(result) {
    state = result;
  }
}

final popularProvider = StateNotifierProvider<PopularProvider, dynamic>((ref) {
  return PopularProvider();
});
