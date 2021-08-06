import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sample_todo_app/config/app_router.dart';
import 'package:sample_todo_app/model/todo.dart';
import 'package:sample_todo_app/state/todo_list.dart';
import 'package:sample_todo_app/widget/custom_checkbox.dart';

class TodoTile extends StatelessWidget {
  final Todo todo;

  const TodoTile({Key? key, required this.todo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var accent = Theme.of(context).accentColor;

    return Dismissible(
      key: ValueKey(todo.id),
      child: ListTile(
        title: Text(
          todo.title,
          style: TextStyle(
            fontSize: 20,
            fontWeight: todo.finished ? FontWeight.normal : FontWeight.bold,
            color: todo.finished ? Colors.grey : Colors.black,
          ),
        ),
        subtitle: Text(DateFormat('hh:mm d MMMM yyyy', 'ru_RU')
            .format(todo.notificationDateTime)),
        trailing: CustomCheckbox(
          onChanged: (value) => _setFinished(context, value),
          value: todo.finished,
        ),
        onTap: () => Navigator.pushNamed(
          context,
          AppRoute.edit_todo,
          arguments: todo,
        ),
      ),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 24),
        color: accent.withOpacity(0.2),
        child: Icon(Icons.delete, color: accent, size: 32),
      ),
      onDismissed: (direction) => _remove(context),
    );
  }

  void _setFinished(BuildContext context, bool finished) =>
      Provider.of<TodoList>(context, listen: false)
          .save(todo.copyWith(finished: finished));

  void _remove(BuildContext context) =>
      Provider.of<TodoList>(context, listen: false).remove(todo);
}
