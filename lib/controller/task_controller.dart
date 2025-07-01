import 'package:todo_app/model/task_model.dart';

class TaskController {
  final List<TaskModel> _tasks = [
    TaskModel(title: "WorkingOut"),
    TaskModel(title: "Sleeping"),
  ];

  List<TaskModel> get tasks => _tasks;
  get tasksCount => _tasks.length;

  void addTask(String title) {
    _tasks.add(TaskModel(title: title));
  }

  void deleteTask(int index) {
    _tasks.removeAt(index);
  }

  void editTask(int index, String val) {
    _tasks[index] = TaskModel(title: val);
  }

  void toggle(int index) {
    _tasks[index].isChecked = !_tasks[index].isChecked;
  }
}
