import 'package:flutter/material.dart';
import 'package:todo/models/todo.dart';
import 'package:todo/theme.dart';

class TodoList extends StatefulWidget {
  const TodoList({super.key, required this.todos});

  final List<Todo> todos;

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: widget.todos.map((todo) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color: todo.priority.color.withOpacity(0.5),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(5, 10, 10, 10),
                    child: Icon(
                      todo.priority.icon,
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          todo.title,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          todo.description,
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 80,
                    child: SafeArea(
                      child: Container(
                        alignment: Alignment.center,
                        color: todo.priority.color[800],
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          todo.priority.title,
                          style: AppTheme.textTheme.titleMedium,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
