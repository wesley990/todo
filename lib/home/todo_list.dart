import 'package:flutter/material.dart';
import 'package:todo/models/todo.dart';

class TodoList extends StatefulWidget {
  const TodoList({super.key, required this.todos});

  final List<Todo> todos;

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.todos.length,
      itemBuilder: (context, index) {
        Todo todo = widget.todos[index];
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              color: todo.priority.color.withOpacity(0.5),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  height: 80, // Replace 50 with the desired row height
                  child: SafeArea(
                    child: Container(
                      alignment: Alignment.center,
                      color: todo.priority.color,
                      padding: const EdgeInsets.all(8.0),
                      child: Text(todo.priority.title),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
