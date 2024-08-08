import 'package:flutter/material.dart';

enum Priority {
  urgent(color: Colors.red, title: 'Urgent', icon: Icons.priority_high),
  high(color: Colors.orange, title: 'High', icon: Icons.star),
  medium(color: Colors.yellow, title: 'Medium', icon: Icons.star_half),
  low(color: Colors.green, title: 'Low', icon: Icons.low_priority);

  final dynamic color;
  final String title;
  final IconData icon;

  const Priority(
      {required this.color, required this.title, required this.icon});

  static List<String> get priorityTitles => [
        Priority.urgent.title,
        Priority.high.title,
        Priority.medium.title,
        Priority.low.title,
      ];
}

class Todo {
  String title;
  String description;
  Priority priority;

  Todo({
    required this.title,
    required this.description,
    required this.priority,
  });
}

List<Todo> dummyTodos = [
  Todo(
    title: 'Buy groceries',
    description: 'Milk, eggs, breasfm,sa.,mfn.a,smnf.,samnf,.masfsafsad',
    priority: Priority.medium,
  ),
  Todo(
    title: 'Finish homework',
    description:
        'Math, Science, Englishsafas.,fn,asmfn.,samnf,samnf.,asmfn.,smn',
    priority: Priority.high,
  ),
  Todo(
    title: 'Go for a run',
    description: '5 km in the parklorem ipsum dolor sit amet',
    priority: Priority.low,
  ),
  Todo(
    title: 'Call mom',
    description: 'Wish her a happy birthday lorem ipsum dolor sit amet',
    priority: Priority.urgent,
  ),
];
