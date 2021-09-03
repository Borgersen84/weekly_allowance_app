import 'package:esther_money_app/database/db_handler.dart';
import 'package:esther_money_app/models/finished_task.dart';
import 'package:esther_money_app/utilities/task_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DeleteTaskDialog {
  static showDeleteDialog(
      BuildContext context,
      DatabaseHandler handler,
      List<FinishedTask> finishedTasks,
      int index,
      TaskList taskList,
      List<ListTile> finishedTaskTiles) {
    final String title = "OjOjOj..";
    final String buttonTextOkay = "OK";
    final String buttonTextReturn = "Avbryt";
    final String message = "Vill du verkligen ta bort denna uppgiften?";

    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        Row(
          children: [
            TextButton(
              onPressed: () async {
                //deleteTask(
                finishedTasks = await handler.retrieveTasks(finishedTasks);
                finishedTasks = taskList.revertListForTaskTiles(finishedTasks);
                handler.deleteTask(finishedTasks[index].id!);
                finishedTasks = await handler.retrieveTasks(finishedTasks);
                finishedTasks = taskList.revertListForTaskTiles(finishedTasks);
                Navigator.pop(context);
              },
              child: Text(buttonTextOkay),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(buttonTextReturn),
            ),
          ],
        )
      ],
    );

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        });
  }

  void deleteTask(DatabaseHandler handler, List<FinishedTask> finishedTasks,
      int index, TaskList taskList, List<ListTile> finishedTaskTiles) async {
    finishedTasks = await handler.retrieveTasks(finishedTasks);
    finishedTasks = taskList.revertListForTaskTiles(finishedTasks);
    handler.deleteTask(index);
    finishedTasks = await handler.retrieveTasks(finishedTasks);
    finishedTasks = taskList.revertListForTaskTiles(finishedTasks);
    //taskList.updateTaskList(finishedTasks, finishedTaskTiles);
  }
}
