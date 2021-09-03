import 'package:esther_money_app/models/weekly_money_task_model.dart';
import 'package:flutter/material.dart';

class WeeklyMoney {
  String? weekNumber;
  List<WeeklyMoneyTask> _weeklyTasks = [];

  WeeklyMoneyTask cleaningTask = WeeklyMoneyTask(
    taskName: "Städa rummet", /*taskIcon: Icon(Icons.email)*/
  );

  WeeklyMoneyTask dishesTask = WeeklyMoneyTask(
    taskName: "Disk", /*taskIcon: Icon(Icons.email)*/
  );

  WeeklyMoneyTask takeOutTrashTask = WeeklyMoneyTask(
    taskName: "Ta ut sopor", /*taskIcon: Icon(Icons.email)*/
  );

  WeeklyMoney(String weekNumber) {
    this.weekNumber = weekNumber;
    _weeklyTasks.add(cleaningTask);
    _weeklyTasks.add(dishesTask);
    _weeklyTasks.add(takeOutTrashTask);
  }

  List<WeeklyMoneyTask> get weeklyTasks => _weeklyTasks;
}
