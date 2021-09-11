import 'package:esther_money_app/models/finished_task.dart';
import 'package:week_of_year/week_of_year.dart';

class WeeklySumCalculator {
  static int calculateSum(List<FinishedTask> taskList) {
    int finalSum = 0;

    for (FinishedTask t in taskList) {
      if (t.weekNumber == DateTime.now().weekOfYear) {
        finalSum += t.valueOfTask!;
      }
    }

    return finalSum;
  }
}
