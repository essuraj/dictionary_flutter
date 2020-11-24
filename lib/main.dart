import 'package:dictionary/pages/home_page.dart';
import 'package:dictionary/utils/theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: DictionaryTheme.lightTheme(context),
      home: HomePage(),
    );
  }
}
