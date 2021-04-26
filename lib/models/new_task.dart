import 'package:flutter/material.dart';

class NewTask {
  String _taskTitle;
  int _taskValue;
  Icon _taskIcon;

  NewTask(this._taskTitle, this._taskValue, this._taskIcon);

  String get taskTitle => _taskTitle;
  int get taskValue => _taskValue;
  Icon get taskIcon => _taskIcon;
}
