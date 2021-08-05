import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_todo_app/config/app_router.dart';
import 'package:sample_todo_app/model/todo.dart';
import 'package:sample_todo_app/state/todo_list.dart';

class TodoTile extends StatelessWidget {
  final Todo todo;

  const TodoTile({Key? key, required this.todo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(todo.id),
      child: ListTile(
        title: Text(
          todo.title,
          style: TextStyle(
            decoration: todo.finished
                ? TextDecoration.lineThrough
                : TextDecoration.none,
          ),
        ),
        subtitle: Text(todo.description),
        trailing: Checkbox(
          onChanged: (value) => _setFinished(context, value ?? false),
          value: todo.finished,
        ),
        onTap: () => Navigator.pushNamed(context, AppRoute.todo_details),
      ),
      direction: DismissDirection.endToStart,
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 24),
        child: Icon(Icons.delete, color: Colors.white),
      ),
      onDismissed: (direction) => _remove(context),
    );
  }

  void _setFinished(BuildContext context, bool finished) =>
      Provider.of<TodoList>(context, listen: false).setFinished(todo, finished);

  void _remove(BuildContext context) =>
      Provider.of<TodoList>(context, listen: false).remove(todo);
}
