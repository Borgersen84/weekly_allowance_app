import 'package:esther_money_app/models/finished_task.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHandler {
  Future<Database> initializeDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'tasks_database.db'),
      onCreate: (database, version) async {
        await database.execute(
          "CREATE TABLE tasks(id INTEGER PRIMARY KEY AUTOINCREMENT, task_title TEXT NOT NULL, task_submitted TEXT NOT NULL, task_value INTEGER, week_number INTEGER)",
        );
      },
      version: 1,
    );
  }

  Future<int> insertTask(List<FinishedTask> tasks) async {
    int result = 0;
    final Database db = await initializeDB();
    for (var task in tasks) {
      result = await db.insert('tasks', task.toMap());
    }
    return result;
  }

  Future<int> insertSingleTask(FinishedTask task) async {
    int result = 0;
    final Database db = await initializeDB();
    result = await db.insert('tasks', task.toMap());

    return result;
  }

  Future<List<FinishedTask>> retrieveTasks(List<FinishedTask> taskList) async {
    final Database db = await initializeDB();
    final List<Map<String, Object?>> queryResult = await db.query('tasks');
    taskList = queryResult.map((e) => FinishedTask.fromMap(e)).toList();
    return queryResult.map((e) => FinishedTask.fromMap(e)).toList();
  }

  Future<void> deleteTask(int id) async {
    final db = await initializeDB();
    await db.delete(
      'tasks',
      where: "id = ?",
      whereArgs: [id],
    );
  }

  Future<void> clearDatabase() async {
    final directory = await getApplicationDocumentsDirectory();
    final path = join(directory.path, 'tasks_database.db');
    await deleteDatabase(path);
  }
}
