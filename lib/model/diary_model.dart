class DiaryModel {
  final int id;
  final String data;
  final String time;

  DiaryModel({this.id, this.data, this.time});

  factory DiaryModel.fromJson(Map<String, dynamic> json) {
    return DiaryModel(
      id: json['id'] as int ?? 0,
      time: json['time'] as String ?? '',
      data: json['data'] as String ?? '',
    );
  }

  static List<DiaryModel> fromDiaryList(List diaryList) {
    List<DiaryModel> diaries = [];
    for (Map<String, dynamic> diary in diaryList) {
      diaries.add(DiaryModel.fromJson(diary));
    }
    return diaries;
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'time': time, 'data': data};
  }
}
