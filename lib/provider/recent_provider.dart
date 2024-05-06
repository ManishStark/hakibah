import 'package:flutter_riverpod/flutter_riverpod.dart';

class RecentProvider extends StateNotifier<dynamic> {
  RecentProvider() : super(null);
  void setRecent(result) {
    state = result;
  }
}

final recentProvider = StateNotifierProvider<RecentProvider, dynamic>((ref) {
  return RecentProvider();
});
