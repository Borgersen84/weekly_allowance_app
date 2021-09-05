import 'package:intl/intl.dart';

class FinishedTask {
  int? id;
  String? taskTitle;
  String? taskSubmitted;
  int? valueOfTask;
  int? weekNumber;

  FinishedTask(
      {this.id,
      required this.taskTitle,
      required this.valueOfTask,
      required this.taskSubmitted,
      required this.weekNumber});

  FinishedTask.fromMap(Map<String, dynamic> res)
      : id = res["id"],
        taskTitle = res["task_title"],
        taskSubmitted = res["task_submitted"],
        valueOfTask = res["task_value"],
        weekNumber = res["week_number"];

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'task_title': taskTitle,
      'task_submitted': taskSubmitted,
      'task_value': valueOfTask,
      'week_number': weekNumber
    };
  }

  String? setTaskSubmitted(DateTime timeNow) {
    DateFormat format = DateFormat("yyyy-MM-dd - kk:mm:ss");
    taskSubmitted = format.format(timeNow);

    return taskSubmitted;
  }
}
