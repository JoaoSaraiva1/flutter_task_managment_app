// ignore_for_file: prefer_const_constructors, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

import '../model/task.dart';
import '../utils/colors.dart';

class TaskItem extends StatelessWidget {
  final Task task;
  final onTaskChanged;
  final onDeleteItem;

  const TaskItem({
    Key? key,
    required this.task,
    required this.onTaskChanged,
    required this.onDeleteItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: ListTile(
        onTap: () {
          onTaskChanged(task);
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        tileColor: Colors.white,
        leading: Icon(
          task.isDone ? Icons.check_box : Icons.check_box_outline_blank,
          color: tmBlue,
        ),
        title: Text(
          task.taskText!,
          style: TextStyle(
            fontSize: 16,
            color: tmBlack,
            decoration: task.isDone ? TextDecoration.lineThrough : null,
          ),
        ),
        trailing: Container(
          padding: EdgeInsets.all(0),
          margin: EdgeInsets.symmetric(vertical: 12),
          height: 35,
          width: 35,
          decoration: BoxDecoration(
            color: tmRed,
            borderRadius: BorderRadius.circular(5),
          ),
          child: IconButton(
            color: Colors.white,
            iconSize: 18,
            icon: Icon(Icons.delete),
            onPressed: () {
              onDeleteItem(task.id);
            },
          ),
        ),
      ),
    );
  }
}
