import 'package:esther_money_app/models/new_task.dart';
import 'package:flutter/material.dart';
import 'package:esther_money_app/models/finished_task.dart';
import 'package:esther_money_app/utilities/popup_message_dialog.dart';

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

  void addTaskToList(
      List<NewTask> newTasks,
      int index,
      List<ListTile> finishedTasks,
      List<FinishedTask> tasks,
      BuildContext context) {
    NewTask task = newTasks[index];
    FinishedTask newTask = FinishedTask(1, task.taskTitle, task.taskValue);
    if (!_checkForDuplicate(tasks, newTask.taskTitle!)) {
      tasks.add(newTask);
      newTask.setTaskSubmitted(DateTime.now());
      ListTile tile = ListTile(
        title: Text(newTask.taskTitle!),
        subtitle: Text("Värde: " + newTask.valueOfTask.toString() + " SEK"),
        trailing: Text(newTask.taskSubmitted!),
      );
      finishedTasks.insert(0, tile);
    } else {
      PopupMessageDialog.showAlertDialog(context, message);
    }
  }

  void testFunctionForDb(FinishedTask task, List<ListTile> finishedTasks) {
    ListTile tile = ListTile(
      title: Text(task.taskTitle!),
      subtitle: Text("Värde: " + task.valueOfTask.toString() + " SEK"),
      trailing: Text("Yello"),
    );
    finishedTasks.insert(0, tile);
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
