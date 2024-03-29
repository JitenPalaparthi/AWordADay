//import 'package:Admin/models/requestWord.dart';
import 'package:Admin/suggestWord.dart';
import 'package:Admin/requestWord.dart';

import 'package:flutter/material.dart';
import 'package:Admin/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
    final mainKey = GlobalKey<ScaffoldState>();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'A Word A Day(Admin)',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        // primarySwatch: Colors.blueGrey,

        brightness: Brightness.light,
        primaryColor: Colors.blueGrey[900],
        accentColor: Colors.blueGrey[300],

        // Define the default font family.
        //fontFamily: 'learning_curve',
      ),
      home: MyHomePage(title: 'A Word A Day(Admin)'),
      );
  }
}


