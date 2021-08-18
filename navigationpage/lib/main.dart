import 'package:flutter/material.dart';
import 'package:navigationpage/sceen1.dart';
import 'package:navigationpage/screen2.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'my app',
      routes: <String, WidgetBuilder>{
        '/screen1': (BuildContext context) => new SecoundPage1(),
        '/screen2': (BuildContext context) => new SecoundPage2(),
      },
      home: SecoundPage1(),
    );
  }
}
