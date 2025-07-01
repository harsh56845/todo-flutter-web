import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/controller/task_controller.dart';
import 'package:todo_app/model/task_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TaskController _controller = TaskController();
  final TextEditingController _tasktitle = TextEditingController();
  final TextEditingController _editTask = TextEditingController();

  _addTask() {
    if (_tasktitle.text.isNotEmpty) {
      setState(() {
        _controller.addTask(_tasktitle.text);
        // _taskList.add({"title": _tasktitle.text, "isChecked": false});
        _tasktitle.clear();
      });
      _snackBarMessage(' Task Added Sucessfully', Colors.green);
    } else {
      _snackBarMessage('⚠️ TextFeild Cannot Empty', Colors.redAccent);
    }
  }

  _delTask(int i) {
    setState(() {
      _controller.deleteTask(i);
    });
    _snackBarMessage(' Task Deleted Sucessfully', Colors.blue);
  }

  _editTaskFun(int i) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Edit Task"),
        content: TextField(
          controller: _editTask,
          decoration: InputDecoration(
            hintText: "Enter new task name",
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // cancel
            },
            child: Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _controller.editTask(i, _editTask.text);
                // _taskList[i] = {"title": _editTask.text, "isChecked": false};
              });
              _snackBarMessage('task Edit SucessFully', Colors.green);
              Navigator.pop(context); // close popup
            },
            child: Text("Save"),
          ),
        ],
      ),
    );
  }

  _snackBarMessage(String str, Color clr) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(str),
        backgroundColor: clr,
        duration: Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<TaskModel> taskList = _controller.tasks;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "📝 ToDo App",
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.0,
          ),
        ),
        centerTitle: true,
        elevation: 4,
        backgroundColor: const Color(0xFF673AB7), // deep purple
        actions: [
          IconButton(
            icon: Icon(Icons.info_outline, color: Colors.white),
            tooltip: "About App",
            onPressed: () {
              showAboutDialog(
                context: context,
                applicationName: "ToDo App",
                applicationVersion: "v1.0",
                children: [Text("Made with ❤️ by Harsh")],
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 50),
            Text(
              "Total tasks: ${_controller.tasksCount}",
              style: TextStyle(color: Colors.grey),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 90),
                SizedBox(width: 300, child: TextField(controller: _tasktitle)),
                SizedBox(
                  width: 60,
                  child: TextButton.icon(
                    onPressed: () => _addTask(),
                    label: Icon(Icons.add, size: 32, color: Colors.green),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Expanded(
              child: SizedBox(
                height: 300,
                width: 500,
                child: ListView.builder(
                  itemCount: taskList.length,
                  itemBuilder: (context, i) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        child: ListTile(
                          title: Text(
                            taskList[i].title,
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                decoration: taskList[i].isChecked
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none,
                              ),
                            ),
                          ),
                          trailing: SizedBox(
                            width: 120,
                            child: Row(
                              children: [
                                IconButton(
                                  onPressed: () => _editTaskFun(i),
                                  icon: Icon(Icons.edit, color: Colors.blue),
                                ),
                                IconButton(
                                  onPressed: () => _delTask(i),
                                  icon: Icon(Icons.delete, color: Colors.red),
                                ),
                                Checkbox(
                                  value: taskList[i].isChecked,
                                  onChanged: (val) {
                                    setState(() {
                                      taskList[i].isChecked = val!;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: Text(
                "Made by Harsh ❤️",
                style: TextStyle(color: Colors.grey, fontSize: 14),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
