import 'package:esther_money_app/models/new_task.dart';
import 'package:flutter/material.dart';
import 'package:esther_money_app/models/finished_task.dart';

class TaskList {
  NewTask dishes = NewTask("Disk", 10, Icon(Icons.add));
  NewTask cleanUpRoom = NewTask("Städa rummet", 50, Icon(Icons.add));
  NewTask takeOutTrash = NewTask("Ta ut sopor", 5, Icon(Icons.add));
  List<NewTask> _taskList = [];

  TaskList() {
    _taskList.add(dishes);
    _taskList.add(cleanUpRoom);
    _taskList.add(takeOutTrash);
  }

  List<NewTask> get taskList => _taskList;

  void addTaskToList(List<NewTask> newTasks, int index,
      List<ListTile> finishedTasks, List<FinishedTask> tasks) {
    NewTask task = newTasks[index];
    FinishedTask newTask = FinishedTask(task.taskTitle, task.taskValue);
    if (!_checkForDuplicate(tasks, newTask.taskTitle)) {
      tasks.add(newTask);
      newTask.setTaskSubmitted(DateTime.now());
      ListTile tile = ListTile(
        title: Text(newTask.taskTitle),
        subtitle: Text("Värde: " + newTask.valueOfTask.toString() + " SEK"),
        trailing: Text(newTask.taskSubmitted),
      );
      finishedTasks.add(tile);
    } else {
      print("You cant add this twice!");
    }
  }

  bool _checkForDuplicate(List<FinishedTask> tasks, String newTaskTitle) {
    String forbiddenTwice = "Städa rummet";
    for (FinishedTask t in tasks) {
      if (t.taskTitle == forbiddenTwice && newTaskTitle == forbiddenTwice) {
        return true;
      }
    }
    return false;
  }
}
