import 'dart:async';

import '../model/diary_model.dart';

export '../model/diary_model.dart';

abstract class DiaryBloc {
  Stream<List<DiaryModel>> getDiaryList();

  void recordDiary(String diaryContent);

  void refreshList();

  void dispose();

  bool get firstSyncDone;
}
