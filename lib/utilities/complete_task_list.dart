import 'package:esther_money_app/models/new_task.dart';
import 'package:flutter/material.dart';

class CompleteTaskList {
  NewTask dishes = NewTask("Disk", 10, Icon(Icons.add));
  NewTask cleanUpRoom = NewTask("Städa rummet", 50, Icon(Icons.add));
  NewTask takeOutTrash = NewTask("Ta ut sopor", 5, Icon(Icons.add));
  List<NewTask> taskList = [];

  CompleteTaskList() {
    taskList.add(dishes);
    taskList.add(cleanUpRoom);
    taskList.add(takeOutTrash);
  }

  List<NewTask> get task_list => taskList;
}
