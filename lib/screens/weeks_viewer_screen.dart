import 'package:flutter/material.dart';

class WeekViewer extends StatefulWidget {
  @override
  _WeekViewerState createState() => _WeekViewerState();
}

class _WeekViewerState extends State<WeekViewer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF7AEF8),
      body: Center(
        child: ElevatedButton(
          child: Text(
            "Click here to return",
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.black,
            ),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
