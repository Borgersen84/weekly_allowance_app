import 'package:intl/intl.dart';

class FinishedTask {
  int? _id;
  String _taskTitle;
  String? _taskSubmitted;
  int? _valueOfTask;

  FinishedTask(this._id, this._taskTitle, this._valueOfTask);

  String? get taskTitle => _taskTitle;
  int? get valueOfTask => _valueOfTask;

  void setTaskSubmitted(DateTime timeNow) {
    DateFormat format = DateFormat("yyyy-MM-dd - kk:mm:ss");
    _taskSubmitted = format.format(timeNow);
  }

  String? get taskSubmitted => _taskSubmitted;
}
