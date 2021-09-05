import 'package:flutter/material.dart';
import 'package:esther_money_app/models/finished_task.dart';

class WeekViewer extends StatefulWidget {
  final List<FinishedTask> finishedTasks;
  WeekViewer({required this.finishedTasks});
  @override
  _WeekViewerState createState() =>
      _WeekViewerState(finishedTasks: finishedTasks);
}

class _WeekViewerState extends State<WeekViewer> {
  List<FinishedTask> finishedTasks;
  _WeekViewerState({required this.finishedTasks});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF7AEF8),
      body: Center(
        child: ElevatedButton(
          child: Text(
            finishedTasks[0].taskTitle.toString(),
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
