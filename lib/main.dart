import 'package:esther_money_app/screens/start_screen.dart';
import 'package:esther_money_app/screens/weeks_viewer_screen.dart';
import 'package:flutter/material.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "/",
      routes: appRoutes(),
    );
  }

  Map<String, Widget Function(BuildContext)> appRoutes() {
    return {
      "/": (context) => StartScreen(),
      "/weeks": (context) => WeekViewer(),
    };
  }
}
