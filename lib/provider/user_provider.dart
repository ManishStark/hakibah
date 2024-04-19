import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserProvider extends StateNotifier<dynamic> {
  UserProvider() : super(null);
  void setUser(result) {
    state = result;
  }
}

final userProvider = StateNotifierProvider<UserProvider, dynamic>((ref) {
  return UserProvider();
});
