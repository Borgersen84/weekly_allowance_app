import 'package:flutter/material.dart';

class WeekViewer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: Text(
            "Click here to return to previous",
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.lightBlue,
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
