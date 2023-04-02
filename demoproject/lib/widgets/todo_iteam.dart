import 'package:demoproject/constants/colors.dart';
import 'package:demoproject/model/todo.dart';
import 'package:flutter/material.dart';

class ToDoIteam extends StatelessWidget {
  const ToDoIteam(
      {super.key,
      required this.todo,
      required this.onToDoChanged,
      required this.onDeleteItem});

  final ToDo todo;
  final onToDoChanged;
  final onDeleteItem;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(bottom: 20),
        child: ListTile(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          onTap: () {
            onToDoChanged(todo);
          },
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          tileColor: Colors.white,
          leading: Icon(
              todo.isDone ? Icons.check_box : Icons.check_box_outline_blank,
              color: tdBlue),
          title: Text(todo.todoText!,
              style: TextStyle(
                  fontSize: 16,
                  color: tdBlack,
                  decoration: todo.isDone ? TextDecoration.lineThrough : null)),
          trailing: Container(
            padding: const EdgeInsets.all(0),
            margin: const EdgeInsets.symmetric(vertical: 7),
            height: 35,
            width: 35,
            decoration: BoxDecoration(
                color: tdRed, borderRadius: BorderRadius.circular(5)),
            child: IconButton(
              onPressed: () {
                onDeleteItem(todo.id);
              },
              icon: const Icon(
                Icons.delete,
                color: Colors.white,
              ),
              iconSize: 18,
            ),
          ),
        ));
  }
}
