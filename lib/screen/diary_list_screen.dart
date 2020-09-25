import 'package:flutter/material.dart';
import 'package:simplediary/bloc/diary_bloc.dart';

import '../bloc/diary_bloc_impl.dart';
import '../util/date_util.dart';
import 'diary_record_screen.dart';

class DiaryListScreen extends StatefulWidget {
  @override
  _DiaryListScreenState createState() => _DiaryListScreenState();
}

class _DiaryListScreenState extends State<DiaryListScreen> {
  DiaryBloc bloc = DiaryBlocImpl();

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Simple Diary')),
      body: buildDiaryList(),
      floatingActionButton: buildFloatingActionButton(context),
    );
  }

  StreamBuilder<List<DiaryModel>> buildDiaryList() {
    return StreamBuilder<List<DiaryModel>>(
      stream: bloc.getDiaryList(),
      builder: (context, snapshot) {
        if (!bloc.firstSyncDone || !snapshot.hasData) return Center(child: CircularProgressIndicator());
        final diaryList = snapshot.data;
        if (diaryList.isEmpty) return Center(child: Text('请写一篇日记吧'));
        return RefreshIndicator(
          onRefresh: () async {
            await Future.delayed(Duration(seconds: 1));
            bloc.refreshList();
          },
          child: ListView.builder(
            physics: AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
            padding: EdgeInsets.all(8),
            itemCount: diaryList.length,
            itemBuilder: (context, index) {
              final diary = diaryList[index];
              return buildDiaryTile(index, diary.data, dateUtil.getDate(date: DateTime.parse(diary.time)));
            },
          ),
        );
      },
    );
  }

  FloatingActionButton buildFloatingActionButton(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: () {
        if (bloc.firstSyncDone)
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => DiaryRecordScreen(bloc: bloc)),
          );
      },
    );
  }

  Widget buildDiaryTile(int index, String text, String date) {
    final indexTextStyle = TextStyle(fontWeight: FontWeight.w100, fontSize: 24);
    final dateTextStyle = TextStyle(fontSize: 8);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          buildDiaryTileLeading(index, indexTextStyle, dateTextStyle, date),
          SizedBox(width: 8),
          buildDiaryTileBody(text),
        ],
      ),
    );
  }

  Expanded buildDiaryTileBody(String text) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.2),
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
        child: Text('$text'),
      ),
    );
  }

  Widget buildDiaryTileLeading(
    int index,
    TextStyle indexTextStyle,
    TextStyle dateTextStyle,
    String date,
  ) {
    return Column(
      children: [
        Text('$index', style: indexTextStyle),
        Text('$date', style: dateTextStyle),
      ],
    );
  }
}
