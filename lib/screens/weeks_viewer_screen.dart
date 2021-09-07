import 'package:flutter/material.dart';
import 'package:esther_money_app/models/finished_task.dart';
import 'package:esther_money_app/utilities/constants.dart';
import 'package:week_of_year/week_of_year.dart';

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

  int currentWeek = DateTime.now().weekOfYear;

  int numberOfTasksDone(String taskName) {
    int num = 0;
    for (var task in finishedTasks) {
      if (task.weekNumber == currentWeek && task.taskTitle == taskName) {
        num++;
      }
    }

    return num;
  }

  int valueOfTasksDone(String taskName) {
    int num = 0;
    for (var task in finishedTasks) {
      if (task.weekNumber == currentWeek && task.taskTitle == taskName) {
        num += task.valueOfTask!;
      }
    }

    return num;
  }

  void goBackOneWeek() {
    setState(() {
      currentWeek--;
    });
  }

  void goForwardOneWeek() {
    setState(() {
      currentWeek++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF7AEF8),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xFFB388EB),
        title: Text(
          MAIN_SCREEN_TITLE,
          style: TextStyle(
            fontSize: 23.0,
            fontWeight: FontWeight.bold,
            color: Color(0xFF9FE7F9),
          ),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                      icon: Icon(Icons.arrow_back_ios_sharp),
                      onPressed: goBackOneWeek),
                  Text("Vecka " + currentWeek.toString()),
                  IconButton(
                      icon: Icon(Icons.arrow_forward_ios_sharp),
                      onPressed: goForwardOneWeek),
                ],
              ),
              flex: 1,
            ),
            Expanded(
              flex: 3,
              child: Container(
                color: Color(0xFFB388EB),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Card(
                      child: ListTile(
                        title: Text("Disk"),
                        subtitle: Text(
                          "Antal: " + numberOfTasksDone("Disk").toString(),
                        ),
                        trailing: Text(
                          "Värde: " + valueOfTasksDone("Disk").toString(),
                        ),
                      ),
                      elevation: 6,
                    ),
                    Card(
                      child: ListTile(
                        title: Text("Städa rummet"),
                        subtitle: Text(
                          "Antal: " +
                              numberOfTasksDone("Städa rummet").toString(),
                        ),
                        trailing: Text(
                          "Värde: " +
                              valueOfTasksDone("Städa rummet").toString(),
                        ),
                      ),
                      elevation: 4,
                    ),
                    Card(
                      child: ListTile(
                        title: Text("Ta ut sopor"),
                        subtitle: Text(
                          "Antal: " +
                              numberOfTasksDone("Ta ut sopor").toString(),
                        ),
                        trailing: Text(
                          "Värde: " +
                              valueOfTasksDone("Ta ut sopor").toString(),
                        ),
                      ),
                      elevation: 2,
                    ),
                  ],
                ),
              ),
            ),
            /*Expanded(
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
              flex: 3,
            ),*/
          ],
        ),
      ),
    );
  }
}
