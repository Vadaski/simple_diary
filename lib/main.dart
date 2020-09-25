import 'package:flutter/material.dart';

import 'screen/diary_list_screen.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Diary App',
      theme: ThemeData.dark().copyWith(),
      home: DiaryListScreen(),
    );
  }
}
