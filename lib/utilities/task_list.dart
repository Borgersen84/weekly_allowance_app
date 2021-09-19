import 'package:esther_money_app/database/db_handler.dart';
import 'package:esther_money_app/models/new_task.dart';
import 'package:flutter/material.dart';
import 'package:esther_money_app/models/finished_task.dart';
import 'package:esther_money_app/utilities/dialog/popup_message_dialog.dart';
import 'package:intl/intl.dart';
import 'package:esther_money_app/utilities/constants.dart';
import 'package:week_of_year/week_of_year.dart';

class TaskList {
  final String titleMessage = "Woopsie..";
  final String message = "Du har redan städat rummet denna veckan!";

  NewTask dishes = NewTask("Disk", 10, Icon(Icons.add));
  NewTask cleanUpRoom = NewTask("Städa rummet", 50, Icon(Icons.add));
  NewTask takeOutTrash = NewTask("Ta ut sopor", 5, Icon(Icons.add));
  NewTask customTask = NewTask("Anpassad", 0, Icon(Icons.add));
  List<NewTask> _taskList = [];

  TaskList() {
    _taskList.add(dishes);
    _taskList.add(cleanUpRoom);
    _taskList.add(takeOutTrash);
    _taskList.add(customTask);
  }

  List<NewTask> get taskList => _taskList;

  String setTaskSubmitted(DateTime timeNow) {
    DateFormat format = DateFormat("yyyy-MM-dd - kk:mm:ss");
    String taskSubmitted = format.format(timeNow);

    return taskSubmitted;
  }

  void addTaskToList(
      DatabaseHandler handler,
      List<NewTask> newTasks,
      int index,
      List<ListTile> finishedTasks,
      List<FinishedTask> tasks,
      BuildContext context) {
    NewTask task = newTasks[index];
    FinishedTask finishedTask = FinishedTask(
        taskTitle: task.taskTitle,
        valueOfTask: task.taskValue,
        taskSubmitted: setTaskSubmitted(DateTime.now()),
        weekNumber: DateTime.now().weekOfYear,
        yearNumber: DateTime.now().year);

    if (!_checkForDuplicate(tasks, finishedTask.taskTitle!)) {
      handler.insertSingleTask(finishedTask);
      tasks.insert(0, finishedTask);
      ListTile tile = ListTile(
        title: Text(finishedTask.taskTitle!),
        subtitle:
            Text(VALUE_TEXT + finishedTask.valueOfTask.toString() + SEK_TEXT),
        trailing: Text(finishedTask.taskSubmitted.toString()),
      );
      finishedTasks.insert(0, tile);
    } else {
      PopupMessageDialog.showAlertDialog(context, message, titleMessage);
    }
  }

  void updateTaskList(List<FinishedTask> finishedTasks,
      List<ListTile> finishedTaskTiles, int weekNumber) {
    finishedTaskTiles.clear();
    for (var task in finishedTasks) {
      if (task.weekNumber == weekNumber) {
        addTaskToTaskTile(task, finishedTaskTiles);
      }
    }
  }

  void addTaskToTaskTile(FinishedTask task, List<ListTile> listTiles) {
    ListTile tile = ListTile(
      title: Text(task.taskTitle!),
      subtitle: Text(VALUE_TEXT + task.valueOfTask.toString() + SEK_TEXT),
      trailing: Text(task.taskSubmitted!),
    );
    listTiles.add(tile);
  }

  List<FinishedTask> revertListForTaskTiles(List<FinishedTask> list) {
    List<FinishedTask> newList = [];
    for (var task in list) {
      newList.insert(0, task);
    }
    list = newList;

    return list;
  }

  bool _checkForDuplicate(List<FinishedTask> tasks, String newTaskTitle) {
    for (FinishedTask t in tasks) {
      if (t.taskTitle == TASK_TWO &&
          newTaskTitle == TASK_TWO &&
          t.weekNumber == DateTime.now().weekOfYear) {
        return true;
      }
    }
    return false;
  }
}
