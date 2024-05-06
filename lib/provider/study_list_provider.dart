import 'package:flutter_riverpod/flutter_riverpod.dart';

class StudyListProvider extends StateNotifier<dynamic> {
  StudyListProvider() : super(null);
  void setStudyList(result) {
    state = result;
  }
}

final studyListProvider =
    StateNotifierProvider<StudyListProvider, dynamic>((ref) {
  return StudyListProvider();
});
