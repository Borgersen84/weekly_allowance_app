import 'package:intl/intl.dart';

class FinishedTask {
  int? id;
  String? taskTitle;
  String? taskSubmitted;
  int? valueOfTask;
  int? weekNumber;
  int? yearNumber;

  FinishedTask(
      {this.id,
      required this.taskTitle,
      required this.valueOfTask,
      required this.taskSubmitted,
      required this.weekNumber,
      required this.yearNumber});

  FinishedTask.fromMap(Map<String, dynamic> res)
      : id = res["id"],
        taskTitle = res["task_title"],
        taskSubmitted = res["task_submitted"],
        valueOfTask = res["task_value"],
        weekNumber = res["week_number"],
        yearNumber = res["year_number"];

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'task_title': taskTitle,
      'task_submitted': taskSubmitted,
      'task_value': valueOfTask,
      'week_number': weekNumber,
      'year_number': yearNumber
    };
  }

  String? setTaskSubmitted(DateTime timeNow) {
    DateFormat format = DateFormat("yyyy-MM-dd - kk:mm:ss");
    taskSubmitted = format.format(timeNow);

    return taskSubmitted;
  }
}
