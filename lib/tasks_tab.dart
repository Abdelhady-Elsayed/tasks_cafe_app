import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TasksTab extends StatefulWidget {
  const TasksTab({super.key});

  @override
  State<TasksTab> createState() => _TasksTabState();
}

class _TasksTabState extends State<TasksTab> {
  final TextEditingController _taskController = TextEditingController();
  List<Map<String, dynamic>> _tasks = [];

  String fullName = "";

  @override
  void initState() {
    super.initState();
    _loadUserName();
  }

  Future<void> _loadUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String firstName = prefs.getString("first_name") ?? "";
    String lastName = prefs.getString("last_name") ?? "";
    setState(() {
      fullName = "$firstName $lastName";
    });
  }

  void _addTask() {
    if (_taskController.text.trim().isEmpty) return;

    setState(() {
      _tasks.add({
        "title": _taskController.text.trim(),
        "completed": false,
      });
      _taskController.clear();
    });
  }

  void _deleteTask(int index) {
    setState(() {
      _tasks.removeAt(index);
    });
  }

  void _toggleComplete(int index) async {
    setState(() {
      _tasks[index]["completed"] = !_tasks[index]["completed"];
    });

    // حفظ المهام المكتملة في SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> completedTasks = _tasks
        .where((task) => task["completed"])
        .map<String>((task) => task["title"])
        .toList();

    await prefs.setStringList("completed_tasks", completedTasks);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            controller: _taskController,
            decoration: InputDecoration(
              labelText: "New Task",
              border: OutlineInputBorder(),
              suffixIcon: IconButton(
                icon: Icon(Icons.add),
                onPressed: _addTask,
              ),
            ),
          ),
          SizedBox(height: 16),
          Expanded(
            child: _tasks.isEmpty
                ? Center(child: Text("No tasks added yet."))
                : ListView.builder(
              itemCount: _tasks.length,
              itemBuilder: (context, index) {
                final task = _tasks[index];
                return Card(
                  child: ListTile(
                    leading: IconButton(
                      icon: Icon(
                        task["completed"]
                            ? Icons.check_circle
                            : Icons.radio_button_unchecked,
                        color: task["completed"] ? Colors.green : null,
                      ),
                      onPressed: () => _toggleComplete(index),
                    ),
                    title: Text(
                      task["title"],
                      style: TextStyle(
                        decoration: task["completed"]
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                      ),
                    ),
                    subtitle: Text("Created by: $fullName"),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _deleteTask(index),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
