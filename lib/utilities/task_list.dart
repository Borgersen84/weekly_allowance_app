import 'package:esther_money_app/database/db_handler.dart';
import 'package:esther_money_app/models/new_task.dart';
import 'package:flutter/material.dart';
import 'package:esther_money_app/models/finished_task.dart';
import 'package:esther_money_app/utilities/dialog/popup_message_dialog.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:esther_money_app/utilities/constants.dart';
import 'package:week_of_year/week_of_year.dart';

class TaskList {
  final String titleMessage = "Woopsie..";
  final String message = "Du har redan städat rummet denna veckan!";

  TextEditingController _textEditingController = TextEditingController();

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

  bool isCustomTask(FinishedTask task) {
    if (task.taskTitle == TASK_ONE ||
        task.taskTitle == TASK_TWO ||
        task.taskTitle == TASK_THREE) {
      return false;
    }

    return true;
  }

  void addTaskToList(
      DatabaseHandler handler,
      List<NewTask> newTasks,
      int index,
      List<ListTile> finishedTaskTiles,
      List<FinishedTask> tasks,
      BuildContext context) async {
    NewTask task = newTasks[index];
    FinishedTask finishedTask;
    if (task.taskTitle != "Anpassad") {
      finishedTask = FinishedTask(
          taskTitle: task.taskTitle,
          valueOfTask: task.taskValue,
          taskSubmitted: setTaskSubmitted(DateTime.now()),
          weekNumber: DateTime.now().weekOfYear,
          //weekNumber: 37,
          yearNumber: DateTime.now().year);
    } else {
      String nameOfTask = "";
      int valueOfTask = 0;
      nameOfTask = await _displayTextInputDialog(context, nameOfTask);
      valueOfTask = await _displayNumberInputDialog(context, valueOfTask);
      print(nameOfTask);
      print(valueOfTask);
      finishedTask = FinishedTask(
          taskTitle: nameOfTask,
          valueOfTask: valueOfTask,
          taskSubmitted: setTaskSubmitted(DateTime.now()),
          weekNumber: DateTime.now().weekOfYear,
          //weekNumber: 37,
          yearNumber: DateTime.now().year);
    }

    if (!_checkForDuplicate(tasks, finishedTask.taskTitle!)) {
      handler.insertSingleTask(finishedTask); // Inserted to database
      tasks.insert(0, finishedTask); // Inserted to list of FinishedTask model
      ListTile tile = ListTile(
        title: Text(finishedTask.taskTitle!),
        subtitle:
            Text(VALUE_TEXT + finishedTask.valueOfTask.toString() + SEK_TEXT),
        trailing: Text(finishedTask.taskSubmitted.toString()),
      );
      finishedTaskTiles.insert(0, tile); // Inserted into list of ListTiles
      if (isCustomTask(finishedTask)) {
        Navigator.pushNamed(context, "/");
      }
    } else {
      PopupMessageDialog.showAlertDialog(context, message, titleMessage);
    }
  }

  Future<int> _displayNumberInputDialog(
      BuildContext context, int number) async {
    return await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Hva är värde på uppgiften?"),
            content: TextField(
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                onChanged: (value) {
                  number = int.parse(value);
                },
                controller: _textEditingController),
            actions: [
              TextButton(
                onPressed: () {
                  _textEditingController.clear();
                  Navigator.pop(context, number);
                },
                child: Text("OK"),
              )
            ],
          );
        });
  }

  Future<String> _displayTextInputDialog(
      BuildContext context, String taskName) async {
    return await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Vad har du gjort för jobb?"),
            content: TextField(
              onChanged: (value) {
                taskName = value;
              },
              controller: _textEditingController,
            ),
            actions: [
              TextButton(
                onPressed: () {
                  _textEditingController.clear();
                  Navigator.pop(context, taskName);
                },
                child: Text("OK"),
              )
            ],
          );
        });
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
