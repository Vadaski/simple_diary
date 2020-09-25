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
    return diaryList.map((diary) => DiaryModel.fromJson(diary)).toList();
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'time': time, 'data': data};
  }
}
