import 'package:flutter/material.dart';
import 'package:yote_shin_application/pages/main_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
            brightness: Brightness.dark,
            appBarTheme: AppBarTheme(
              foregroundColor: Colors.white,
              backgroundColor: Colors.grey[900],
            ),
            primarySwatch: Colors.orange),
        home:  MainPage());
  }
}
