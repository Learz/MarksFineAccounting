import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:marks_fine_accounting/constants/colors.dart';

import '../models/todo.dart';

class TodoItem extends StatelessWidget {
  final Todo todo;
  final onTodoChanged;
  final onTodoDeleted;

  const TodoItem({Key? key, required this.todo, required this.onTodoChanged, required this.onTodoDeleted}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(bottom: 10),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 8),
          onTap: () {
            onTodoChanged(todo);
          },
          tileColor: MyTheme.clearColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          leading: Icon(
            todo.done ? Icons.check_circle : Icons.circle_outlined,
            color: MyTheme.secondaryColor,
          ),
          title: Text(
            todo.text ?? "",
            style: TextStyle(
                fontSize: 16,
                color: MyTheme.textColor,
                decoration: todo.done ? TextDecoration.lineThrough : null),
          ),
          trailing: Material(
            color: MyTheme.cancelColor,
            clipBehavior: Clip.antiAlias,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: IconButton(
              color: Colors.white,
              iconSize: 18,
              icon: Icon(Icons.delete),
              onPressed: () {
                onTodoDeleted(todo.id);
              },
            ),
          ),
        ));
  }
}
