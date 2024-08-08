import 'package:flutter/material.dart';
import 'package:todo/home/todo_list.dart';
import 'package:todo/models/todo.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Todo> todos = dummyTodos;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo App'),
      ),
      body: TodoList(todos: todos),
    );
  }
}
