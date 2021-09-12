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

  DateTime _dateTime = DateTime.now();
  bool isOutOfRAnge = true;

  int currentWeek = 0;
  int currentYear = 0;
  List<String> listOfTasks = [];

  @override
  void initState() {
    super.initState();
    listOfTasks.add(TASK_ONE);
    listOfTasks.add(TASK_TWO);
    listOfTasks.add(TASK_THREE);
    currentYear = _dateTime.year;
    currentWeek = _dateTime.weekOfYear;
  }

  int numberOfTasksDone(String taskName) {
    int num = 0;
    for (var task in finishedTasks) {
      if (task.weekNumber == currentWeek &&
          task.taskTitle == taskName &&
          task.yearNumber == currentYear) {
        num++;
      }
    }

    return num;
  }

  int valueOfTasksDone(String taskName) {
    int num = 0;
    for (var task in finishedTasks) {
      if (task.weekNumber == currentWeek &&
          task.taskTitle == taskName &&
          task.yearNumber == currentYear) {
        num += task.valueOfTask!;
      }
    }

    return num;
  }

  int getTotalValueOfAllTasksDone() {
    int num = 0;
    for (var s in listOfTasks) {
      num += valueOfTasksDone(s);
    }
    return num;
  }

  int getTotalNumberOfTasksDone() {
    int num = 0;
    for (var s in listOfTasks) {
      num += numberOfTasksDone(s);
    }

    return num;
  }

  void goBackOneWeek() {
    isOutOfRAnge = false;
    setState(() {
      if (currentWeek == 1) {
        _dateTime = DateTime(currentYear--);
        currentWeek = _dateTime.weekOfYear;
      } else
        currentWeek--;
    });
  }

  void goForwardOneWeek() {
    if (currentWeek == _dateTime.weekOfYear) {
      isOutOfRAnge = true;
    }
    if (!isOutOfRAnge) {
      setState(() {
        currentWeek++;
      });
    }
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
            WeekViewerPaddedTextField(
              padding: EdgeInsets.fromLTRB(0, 8.0, 0, 0),
              fontSize: 20.0,
              text: currentYear.toString(),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                      icon: Icon(Icons.arrow_back_ios_sharp),
                      onPressed: goBackOneWeek),
                  Text(
                    WEEK_TEXT + currentWeek.toString(),
                    style: TextStyle(fontSize: 22.0),
                  ),
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
                    taskHistoryCard(
                        TASK_ONE,
                        QUANTITY_TEXT + numberOfTasksDone(TASK_ONE).toString(),
                        VALUE_TEXT +
                            valueOfTasksDone(TASK_ONE).toString() +
                            SEK_TEXT,
                        6.0),
                    taskHistoryCard(
                        TASK_TWO,
                        QUANTITY_TEXT + numberOfTasksDone(TASK_TWO).toString(),
                        VALUE_TEXT +
                            valueOfTasksDone(TASK_TWO).toString() +
                            SEK_TEXT,
                        4.0),
                    taskHistoryCard(
                        TASK_THREE,
                        QUANTITY_TEXT +
                            numberOfTasksDone(TASK_THREE).toString(),
                        VALUE_TEXT +
                            valueOfTasksDone(TASK_THREE).toString() +
                            SEK_TEXT,
                        2.0)
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFF8093F1),
                  border: Border.all(color: Color(0xFFF7AEF8), width: 4.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Center(
                      child: WeekViewerPaddedTextField(
                        padding: EdgeInsets.all(8.0),
                        text: "Total",
                        fontSize: 20.0,
                      ),
                    ),
                    WeekViewerPaddedTextField(
                      padding: EdgeInsets.all(8.0),
                      text: "Totalt antal utförda uppgifter: " +
                          getTotalNumberOfTasksDone().toString(),
                      fontSize: 15.0,
                    ),
                    WeekViewerPaddedTextField(
                      padding: EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 40.0),
                      text: "Pengar gjort: " +
                          getTotalValueOfAllTasksDone().toString() +
                          SEK_TEXT,
                      fontSize: 15.0,
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 6.0,
                      child: Container(
                        color: Color(0xFFF7AEF8),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Container taskHistoryCard(String taskName, String numberOfTasks,
      String taskValue, double elevation) {
    return Container(
      height: 125.0,
      margin: EdgeInsets.all(3.0),
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xFFF7AEF8), width: 4),
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Card(
        color: Color(0xFF9fe7f9),
        child: ListTile(
          title: Text(
            taskName,
            style: TextStyle(fontSize: 25.0),
          ),
          subtitle: Text(
            numberOfTasks,
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          trailing: Text(
            taskValue,
            style: TextStyle(fontSize: 20.0),
          ),
        ),
        elevation: elevation,
      ),
    );
  }
}

class WeekViewerPaddedTextField extends StatelessWidget {
  final EdgeInsetsGeometry padding;
  final double fontSize;
  final String text;

  WeekViewerPaddedTextField(
      {required this.padding, required this.fontSize, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Text(
        text,
        style: TextStyle(fontSize: fontSize),
      ),
    );
  }
}
