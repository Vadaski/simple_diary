import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:simplediary/model/diary_model.dart';

import 'diary_bloc.dart';

final String baseUrl = 'https://diary-api.ktor.tips/';
final String getUrl = '${baseUrl}api/v1/GetDiaryList';
final String postUrl = '${baseUrl}api/v1/PushDiaryList';

class DiaryBlocImpl implements DiaryBloc {
  bool _firstSyncDone = false;

  bool get firstSyncDone => _firstSyncDone;

  DiaryBlocImpl() {
    refreshList();
  }

  StreamController<List<DiaryModel>> _diaryListController = StreamController.broadcast();
  List<DiaryModel> _diaries = [];

  @override
  Stream<List<DiaryModel>> getDiaryList() => _diaryListController.stream;

  Sink<List<DiaryModel>> get _sink => _diaryListController.sink;

  @override
  void recordDiary(String diaryContent) {
    final diary = DiaryModel(
      id: _diaries.length,
      data: diaryContent,
      time: DateTime.now().toIso8601String(),
    );

    _diaries.add(diary);
    _sink.add(_diaries);
    pushToNetwork();
  }

  void pushToNetwork() {
    try {
      final body = json.encode({'data': _diaries});
      http.post(postUrl, headers: {"Content-Type": "application/json"}, body: body);
    } catch (e) {
      print(e);
    }
  }

  @override
  void refreshList() async {
    try {
      final res = await http.get(getUrl);
      if (res.statusCode == 200) {
        List diaryList = json.decode(res.body)['data'];
        _diaries = DiaryModel.fromDiaryList(diaryList);
        _sink.add(_diaries);
      }
    } catch (e) {
      print(e);
    }
    _firstSyncDone = true;
  }

  @override
  void dispose() {
    _diaryListController.close();
  }
}
