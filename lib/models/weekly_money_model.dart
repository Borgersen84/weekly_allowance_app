import 'package:flutter/material.dart';

class WeeklyMoney {
  String weekNumber;
  String moneyEarned;
  List<String> weeklyTasks;
  Icon progressIcon;

  WeeklyMoney(
      {this.weekNumber, this.moneyEarned, this.weeklyTasks, this.progressIcon});
}
