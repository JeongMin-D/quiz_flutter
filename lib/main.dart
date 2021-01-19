import 'package:flutter/material.dart';
import 'package:quiz_app_test/screen/screen_home.dart';
import 'package:quiz_app_test/screen/screen_start.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Quiz App',
      home: StartApp(),
    );
  }
}
