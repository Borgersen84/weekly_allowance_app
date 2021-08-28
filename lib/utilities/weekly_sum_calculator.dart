import 'package:esther_money_app/models/finished_task.dart';

class WeeklySumCalculator {
  static int calculateSum(List<FinishedTask> taskList) {
    int finalSum = 0;

    for (FinishedTask t in taskList) {
      finalSum += t.valueOfTask!;
    }

    return finalSum;
  }
}
