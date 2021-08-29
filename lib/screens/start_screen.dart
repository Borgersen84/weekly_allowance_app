import 'package:esther_money_app/database/db_helper.dart';
import 'package:esther_money_app/models/finished_task.dart';
import 'package:esther_money_app/models/new_task.dart';
import 'package:esther_money_app/utilities/task_list.dart';
import 'package:flutter/material.dart';
import 'package:esther_money_app/widgets/drop_down_button.dart';
import 'dart:core';
import 'package:esther_money_app/utilities/constants.dart';
import 'package:esther_money_app/widgets/menuitems/menu_item_row.dart';
import 'package:esther_money_app/widgets/menuitems/menu_item_container.dart';
import 'package:esther_money_app/models/weekly_money_model.dart';
import 'package:esther_money_app/utilities/weekly_sum_calculator.dart';
import 'package:intl/intl.dart';
import 'package:week_of_year/week_of_year.dart';

class StartScreen extends StatefulWidget {
  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  ListTile tile = ListTile();
  List<ListTile> finishedTasks = [];
  List<ListTile> tasksToAdd = [];
  List<NewTask> newTasks = [];
  List<FinishedTask> tasks = [];
  TaskList taskList = TaskList();
  WeeklyMoney moneyWeekly =
      WeeklyMoney("Vecka " + DateTime.now().weekOfYear.toString());

  late DatabaseHelper handler;

  @override
  void initState() {
    super.initState();
    this.handler = DatabaseHelper();
    //this.handler.clearTable();
    this.handler.initializeDB().whenComplete(() async {
      tasks = await this.handler.retrieveTasks(tasks);
      taskList.addTasks(tasks, finishedTasks);
      setState(() {});
    });

    newTasks = taskList.taskList;

    for (NewTask task in newTasks) {
      tile = ListTile(
        title: Text(task.taskTitle),
        subtitle: Text("Värde: " + task.taskValue.toString()),
        trailing: task.taskIcon,
      );

      tasksToAdd.add(tile);
    }
  }

  /*Future<int> addTasks() async {
    print("inside addTasks");
    FinishedTask taskOne = FinishedTask(
        taskTitle: "Diska",
        valueOfTask: 5,
        taskSubmitted: setTaskSubmitted(DateTime.now()));
    FinishedTask taskTwo = FinishedTask(
        taskTitle: "Fjerta",
        valueOfTask: 5,
        taskSubmitted: setTaskSubmitted(DateTime.now()));
    List<FinishedTask> listOfTasks = [taskOne, taskTwo];
    //tasks = listOfTasks;
    return await this.handler.insertTask(listOfTasks);
  }*/

  List<DropdownMenuItem> addItems() {
    DropdownMenuItem dropDown = DropdownMenuItem(
      child: MenuItemContainer(
        MenuItemRow("Last week", kMenuIcon),
      ),
    );
    List<DropdownMenuItem> menuItems = [];
    menuItems.add(dropDown);

    return menuItems;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFD3BAF3),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xFFB388EB),
        title: Text(
          "Esther's lista",
          style: TextStyle(
            fontSize: 23.0,
            fontWeight: FontWeight.bold,
            color: Color(0xFF9FE7F9),
          ),
        ),
        actions: [
          DropDownMenuButton(
            addItems(),
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
                            taskList.addTaskToList(this.handler, newTasks,
                                index, finishedTasks, tasks, context);
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
      body: finishedTasks.length > 0
          ? _mainBody()
          : Center(
              child: Text("Listan är tom. Du måste jobba"),
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
              itemCount: finishedTasks.length,
              itemBuilder: (context, index) {
                return FinishedTaskCard(
                  finishedTasks: finishedTasks,
                  indexOfList: index,
                  elevationOfCard: 7.0,
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
                      moneyWeekly.weekNumber!,
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
                            Text(moneyWeekly.weeklyTasks[index].taskName!),
                            moneyWeekly.weeklyTasks[index].taskIcon,
                          ],
                        );
                      }),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.attach_money,
                        size: 25.0,
                      ),
                      Text(
                        WeeklySumCalculator.calculateSum(tasks).toString() +
                            " SEK",
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
  final List<ListTile> finishedTasks;
  final int indexOfList;
  final double elevationOfCard;

  FinishedTaskCard(
      {required this.finishedTasks,
      required this.indexOfList,
      required this.elevationOfCard});

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
        child: finishedTasks[indexOfList],
      ),
    );
  }
}
