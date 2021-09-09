import 'package:esther_money_app/database/db_handler.dart';
import 'package:esther_money_app/models/finished_task.dart';
import 'package:esther_money_app/models/new_task.dart';
import 'package:esther_money_app/screens/weeks_viewer_screen.dart';
import 'package:esther_money_app/utilities/task_list.dart';
import 'package:flutter/material.dart';
import 'dart:core';
import 'package:esther_money_app/utilities/constants.dart';
import 'package:esther_money_app/models/weekly_money_model.dart';
import 'package:esther_money_app/utilities/weekly_sum_calculator.dart';
import 'package:week_of_year/week_of_year.dart';
import 'package:esther_money_app/utilities/constants.dart';

class StartScreen extends StatefulWidget {
  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  ListTile tile = ListTile();
  List<ListTile> finishedTaskTiles = [];
  List<ListTile> tasksToAdd = [];
  List<NewTask> newTasks = [];
  List<FinishedTask> finishedTasks = [];
  TaskList taskList = TaskList();

  static int weekOfTheYear = DateTime.now().weekOfYear;
  //static int weekOfTheYear = 39;
  static String weekOfYearStr = weekOfTheYear.toString();

  WeeklyMoney moneyWeekly = WeeklyMoney(WEEK_TEXT + weekOfYearStr);

  late DatabaseHandler handler;

  int numberOfCleaningsDone = 0;
  int numberOfDishesDone = 0;
  int numberOfTakingOutTrashDone = 0;

  @override
  void initState() {
    super.initState();
    this.handler = DatabaseHandler();
    //this.handler.clearDatabase();
    initiateDatabaseOnStartup();
    newTasks = taskList.taskList;
    addNewTasksToFloatingButtonMenu();
  }

  void addNewTasksToFloatingButtonMenu() {
    for (NewTask task in newTasks) {
      tile = ListTile(
        title: Text(task.taskTitle),
        subtitle: Text(VALUE_TEXT + task.taskValue.toString()),
        trailing: task.taskIcon,
      );

      tasksToAdd.add(tile);
    }
  }

  void initiateDatabaseOnStartup() {
    this.handler.initializeDB().whenComplete(() async {
      finishedTasks = await this.handler.retrieveTasks(finishedTasks);
      finishedTasks = taskList.revertListForTaskTiles(finishedTasks);
      setState(() {
        taskList.updateTaskList(
            finishedTasks, finishedTaskTiles, weekOfTheYear);
      });
    });
  }

  void deleteTask(int index) async {
    finishedTasks = await handler.retrieveTasks(finishedTasks);
    finishedTasks = taskList.revertListForTaskTiles(finishedTasks);
    this.handler.deleteTask(finishedTasks[index].id!);
    finishedTasks = await handler.retrieveTasks(finishedTasks);
    finishedTasks = taskList.revertListForTaskTiles(finishedTasks);
    setState(() {
      taskList.updateTaskList(finishedTasks, finishedTaskTiles, weekOfTheYear);
    });
  }

  int findNumberOfTasksDone(List<FinishedTask> taskList, String taskName) {
    int num = 0;
    for (var task in taskList) {
      if (task.taskTitle == taskName) {
        num += 1;
      }
    }

    return num;
  }

  /* List<DropdownMenuItem> addItems() {
    DropdownMenuItem dropDown = DropdownMenuItem(
      child: MenuItemContainer(
        MenuItemRow("Last week", kMenuIcon),
      ),
    );
    List<DropdownMenuItem> menuItems = [];
    menuItems.add(dropDown);

    return menuItems;
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFD3BAF3),
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
        actions: [
          /*DropDownMenuButton(
            addItems(),
          ),*/
          GestureDetector(
            child: Icon(Icons.calendar_view_day_rounded,
                color: Color(0xFF9FE7F9), size: 45),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => WeekViewer(finishedTasks: finishedTasks),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFFF7AEF8),
        elevation: 5,
        child: Icon(Icons.add),
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (context) {
                return Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: 2, color: Colors.white),
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(25.0),
                    ),
                    color: Color(0xFFF7AEF8),
                  ),
                  height: 300,
                  child: ListView.builder(
                      padding: EdgeInsets.all(8.0),
                      itemCount: tasksToAdd.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {});
                            taskList.addTaskToList(
                                this.handler,
                                newTasks,
                                index,
                                finishedTaskTiles,
                                finishedTasks,
                                context);
                          },
                          child: AddTaskCard(
                            tasksToAdd: tasksToAdd,
                            indexOfList: index,
                            elevationOfCard: 6.0,
                          ),
                        );
                      }),
                );
              });
        },
      ),
      body: finishedTaskTiles.length > 0
          ? _mainBody()
          : Center(
              child: Text(EMPTY_LIST_MESSAGE),
            ),
    );
  }

  Column _mainBody() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          flex: 3,
          child: ListView.builder(
              padding: EdgeInsets.all(8.0),
              itemCount: finishedTaskTiles.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  child: FinishedTaskCard(
                    finishedTaskTiles: finishedTaskTiles,
                    indexOfList: index,
                    elevationOfCard: 7.0,
                  ),
                  onLongPress: () => deleteTask(index),
                );
              }),
        ),
        SizedBox(
          width: double.infinity,
          height: 6.0,
          child: Container(
            color: Color(0xFF72DDF7),
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            decoration: BoxDecoration(
              color: Color(0xFF91A0F3),
              border: Border.all(color: Color(0xFFB388EB), width: 2),
            ),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      WEEK_TEXT + weekOfYearStr,
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: ListView.builder(
                      itemCount: moneyWeekly.weeklyTasks.length,
                      itemBuilder: (context, index) {
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              moneyWeekly.weeklyTasks[index].taskName! +
                                  ": " +
                                  findNumberOfTasksDone(
                                          finishedTasks,
                                          moneyWeekly
                                              .weeklyTasks[index].taskName!)
                                      .toString() +
                                  " count",
                            ),
                            //moneyWeekly.weeklyTasks[index].taskIcon,
                          ],
                        );
                      }),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      /*Icon(
                        Icons.attach_money,
                        size: 25.0,
                      ),*/
                      Text(
                        WeeklySumCalculator.calculateSum(finishedTasks)
                                .toString() +
                            SEK_TEXT,
                        style: TextStyle(fontSize: 25.0),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Icon(
                    Icons.emoji_emotions_sharp,
                    color: Colors.yellow,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class AddTaskCard extends StatelessWidget {
  final List<ListTile> tasksToAdd;
  final int indexOfList;
  final double elevationOfCard;

  AddTaskCard(
      {required this.tasksToAdd,
      required this.indexOfList,
      required this.elevationOfCard});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFF7AEF8),
        border: Border.all(color: Colors.white, width: 1.5),
      ),
      child: Card(
        elevation: elevationOfCard,
        color: Color(0xFFB388EB),
        child: tasksToAdd[indexOfList],
      ),
    );
  }
}

class FinishedTaskCard extends StatelessWidget {
  final List<ListTile> finishedTaskTiles;
  final int indexOfList;
  final double elevationOfCard;

  FinishedTaskCard({
    required this.finishedTaskTiles,
    required this.indexOfList,
    required this.elevationOfCard,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 3.0, horizontal: 0),
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xFFB388EB), width: 2),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Card(
        elevation: elevationOfCard,
        color: Color(0xFFF7AEF8),
        child: finishedTaskTiles[indexOfList],
      ),
    );
  }
}
