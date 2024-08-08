import 'package:flutter/material.dart';
import 'package:todo/home/todo_list.dart';
import 'package:todo/models/todo.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  late List<Todo> todos;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _selectedPriority = Priority.low.title;
  String _title = '';
  String _description = '';

  @override
  void initState() {
    super.initState();
    todos = [];
  }

  @override
  void dispose() {
    _formKey.currentState?.dispose();
    todos.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo App'),
      ),
      body: Column(
        children: [
          Expanded(child: TodoList(todos: todos)),
          Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Title',
                    hintText: 'Enter the title of the todo',
                  ),
                  maxLength: 20,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a title';
                    }
                    return null;
                  },
                  onSaved: (newValue) {
                    _title = newValue ?? '';
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Description',
                    hintText: 'Enter the description of the todo',
                  ),
                  maxLength: 40,
                  validator: (value) {
                    if (value == null || value.isEmpty || value.length < 5) {
                      return 'Please enter a description';
                    }
                    return null;
                  },
                  onSaved: (newValue) {
                    _description = newValue ?? '';
                  },
                ),
                const SizedBox(height: 10),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    labelText: 'Priority',
                    hintText: 'Select the priority of the todo',
                  ),
                  value: _selectedPriority,
                  items: Priority.priorityTitles
                      .map((String priority) => DropdownMenuItem<String>(
                            value: priority,
                            child: Text(priority),
                          ))
                      .toList(),
                  onChanged: (String? newValue) {
                    debugPrint('Selected priority: $newValue');
                    _selectedPriority = newValue ?? Priority.low.title;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select a priority';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    final formState = _formKey.currentState;
                    if (formState != null && formState.validate()) {
                      formState.save();

                      final newTodo = Todo(
                        title: _title,
                        description: _description,
                        priority: Priority.values.firstWhere(
                          (priority) => priority.title == _selectedPriority,
                          orElse: () => Priority.medium, // Provide a default
                        ),
                      );

                      setState(() {
                        todos.add(newTodo);
                      });

                      _title = '';
                      _description = '';
                      _selectedPriority = Priority.low.title;
                      formState.reset();
                    }
                  },
                  child: const Text('Add Todo'),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
