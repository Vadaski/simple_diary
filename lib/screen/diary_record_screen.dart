import 'package:flutter/material.dart';

import '../bloc/diary_bloc.dart';
import '../util/date_util.dart';

class DiaryRecordScreen extends StatelessWidget {
  final DiaryBloc bloc;
  DiaryRecordScreen({@required this.bloc});

  final TextEditingController _textEditingController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: buildDiaryTextField(),
      floatingActionButton: buildFloatingActionButton(context),
    );
  }

  FloatingActionButton buildFloatingActionButton(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.check),
      onPressed: () => recordDiary(context),
    );
  }

  Widget buildDiaryTextField() {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => _focusNode.requestFocus(),
      child: SizedBox.expand(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            maxLines: null,
            focusNode: _focusNode,
            decoration: InputDecoration(border: InputBorder.none),
            controller: _textEditingController,
          ),
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      centerTitle: false,
      title: Text('${dateUtil.getDate()}'),
    );
  }

  void recordDiary(BuildContext context) {
    final text = _textEditingController.text;
    if (text.isEmpty) return;
    bloc.recordDiary(text);
    Navigator.of(context).pop();
  }
}
