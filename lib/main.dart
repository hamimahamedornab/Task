import 'package:flutter/material.dart';

void main() {
  runApp(const TaskManagementApp());
}

class TaskManagementApp extends StatelessWidget {
  const TaskManagementApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Task Management',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const TaskListScreen(),
    );
  }
}

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({super.key});

  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  List<Task> tasks = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreen,
      appBar: AppBar(
        title: const Text('Task List'),
      ),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          return ListTile(

            title: Text(tasks[index].title),
            subtitle: Text(tasks[index].description),

            onLongPress: () => _showDeleteTaskBottomSheet(tasks[index]),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddTaskDialog(),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddTaskDialog() {
    showDialog(
      context: context,
      builder: (context) {
        String title = '';
        String description = '';
        DateTime deadline = DateTime.now();

        return AlertDialog(
          title: const Text('Add Task'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: const InputDecoration(
                    labelText: 'Title',enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 3,color: Colors.greenAccent)
                )
                ),
                onChanged: (value) => title = value,
              ),
              TextField(
                decoration: const InputDecoration(
                    labelText: 'Description',enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 3,color: Colors.greenAccent)
                )
                ),
                onChanged: (value) => description = value,
              ),
              TextField(
                decoration: const InputDecoration(
                    labelText: 'Deadline',enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 3,color: Colors.greenAccent)
                )
                ),
                keyboardType: TextInputType.datetime,
                onChanged: (value) => deadline = DateTime.parse(value),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  tasks.add(Task(title, description, deadline));
                });
                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }



  void _showDeleteTaskBottomSheet(Task task) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Task Details',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16.0),
              Text('Title: ${task.title}'),
              Text('Description: ${task.description}'),
              Text('Deadline: ${task.deadline.toString()}'),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    tasks.remove(task);
                  });
                  Navigator.of(context).pop();
                },
                child: const Text('Delete'),
              ),
            ],
          ),
        );
      },
    );
  }
}

class Task {
  final String title;
  final String description;
  final DateTime deadline;

  Task(this.title, this.description, this.deadline);
}
