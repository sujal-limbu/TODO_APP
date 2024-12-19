import 'package:flutter/material.dart';
import 'package:todo/todobox.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  // Example list to manage tasks
  final List<Map<String, dynamic>> tasks = [
    {"name": "Make note", "isChecked": false},
    {"name": "Go shopping", "isChecked": true},
  ];

  // Function to show dialog for inputting task name
  Future<String?> TaskName() async {
    TextEditingController controller = TextEditingController();

    return await showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Enter Task Name'),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(hintText: 'Task Name'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, controller.text); // Return entered text
              },
              child: const Text('Add'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Cancel the dialog
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  // Function to delete a task
  void deleteTask(int index) {
    setState(() {
      tasks.removeAt(index); // Removes the task at the specified index
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[400],
      appBar: AppBar(
        title: const Text('TO-DO APP'),
        centerTitle: true,
        backgroundColor: Colors.grey[600],
      ),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          return Dismissible(
            key: Key(tasks[index]['name']),
            direction: DismissDirection.endToStart,
            onDismissed: (direction) {
              deleteTask(index); // Delete the task when swiped
            },
            background: Container(
              color: Colors.red, // Red background on swipe
              child: const Icon(
                Icons.delete,
                color: Colors.white,
                size: 40.0,
              ),
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.only(right: 20),
            ),
            child: Todobox(
              name: tasks[index]['name'],
              isChecked: tasks[index]['isChecked'],
              onChanged: (value) {
                setState(() {
                  tasks[index]['isChecked'] =
                      !(tasks[index]['isChecked'] ?? false);
                });
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Show the dialog and await the task name
          String? newTaskName = await TaskName();
          if (newTaskName != null && newTaskName.isNotEmpty) {
            setState(() {
              tasks.add({"name": newTaskName, "isChecked": false});
            });
          }
        },
        backgroundColor: Colors.grey[400],
        child: const Icon(Icons.add),
      ),
    );
  }
}
