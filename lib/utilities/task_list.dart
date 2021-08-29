import 'package:esther_money_app/database/db_helper.dart';
import 'package:esther_money_app/models/new_task.dart';
import 'package:flutter/material.dart';
import 'package:esther_money_app/models/finished_task.dart';
import 'package:esther_money_app/utilities/popup_message_dialog.dart';
import 'package:intl/intl.dart';

class TaskList {
  final String message = "Du har redan städat rummet denna veckan!";

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

  String setTaskSubmitted(DateTime timeNow) {
    DateFormat format = DateFormat("yyyy-MM-dd - kk:mm:ss");
    String taskSubmitted = format.format(timeNow);

    return taskSubmitted;
  }

  void addTaskToList(
      DatabaseHelper handler,
      List<NewTask> newTasks,
      int index,
      List<ListTile> finishedTasks,
      List<FinishedTask> tasks,
      BuildContext context) {
    NewTask task = newTasks[index];
    FinishedTask newTask = FinishedTask(
        taskTitle: task.taskTitle,
        valueOfTask: task.taskValue,
        taskSubmitted: setTaskSubmitted(DateTime.now()));
    if (!_checkForDuplicate(tasks, newTask.taskTitle!)) {
      handler.insertSingleTask(newTask);
      tasks.add(newTask);
      //newTask.setTaskSubmitted(DateTime.now());
      ListTile tile = ListTile(
        title: Text(newTask.taskTitle!),
        subtitle: Text("Värde: " + newTask.valueOfTask.toString() + " SEK"),
        trailing: Text(newTask.setTaskSubmitted(DateTime.now())!),
      );
      finishedTasks.insert(0, tile);
    } else {
      PopupMessageDialog.showAlertDialog(context, message);
    }
  }

  void addTasks(
      List<FinishedTask> finishedTasks, List<ListTile> finishedTaskTiles) {
    for (var task in finishedTasks) {
      /*ListTile tile = ListTile(
        title: Text(task.taskTitle!),
        subtitle: Text("Värde: " + task.valueOfTask.toString() + " SEK"),
        trailing: Text(task.taskSubmitted!),
      );
      finishedTaskTiles.insert(0, tile);*/
      addTaskToTaskTile(task, finishedTaskTiles);
    }
  }

  void addTaskToTaskTile(FinishedTask task, List<ListTile> listTiles) {
    ListTile tile = ListTile(
      title: Text(task.taskTitle!),
      subtitle: Text("Värde: " + task.valueOfTask.toString() + " SEK"),
      trailing: Text(task.taskSubmitted!),
    );
    listTiles.insert(0, tile);
  }

  void testFunctionForDb(FinishedTask task, List<ListTile> finishedTasks) {
    ListTile tile = ListTile(
      title: Text(task.taskTitle!),
      subtitle: Text("Värde: " + task.valueOfTask.toString() + " SEK"),
      trailing: Text(task.taskSubmitted!),
    );
    finishedTasks.insert(0, tile);
  }

  void testFunctionForDbTwo(
      List<FinishedTask> finishedTasks, List<ListTile> finishedTaskTiles) {
    print("test : " + finishedTasks.length.toString());
    for (var task in finishedTasks) {
      ListTile tile = ListTile(
        title: Text(task.taskTitle!),
        subtitle: Text("Värde: " + task.valueOfTask.toString() + " SEK"),
        trailing: Text(task.taskSubmitted!),
      );
      finishedTaskTiles.insert(0, tile);
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
