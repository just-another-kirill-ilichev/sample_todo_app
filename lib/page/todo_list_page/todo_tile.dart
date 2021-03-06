import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_todo_app/config/app_router.dart';
import 'package:sample_todo_app/config/app_settings.dart';
import 'package:sample_todo_app/model/todo.dart';
import 'package:sample_todo_app/state/todo_change_notifier.dart';
import 'package:sample_todo_app/widget/custom_checkbox.dart';
import 'package:sample_todo_app/widget/custom_list_tile.dart';
import 'package:sample_todo_app/widget/dialog/platform_dialog.dart';
import 'package:sample_todo_app/widget/dialog/remove_dialog.dart';

class TodoTile extends StatelessWidget {
  final Todo todo;

  const TodoTile({Key? key, required this.todo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var accent = Theme.of(context).accentColor;

    return Dismissible(
      key: ValueKey(todo.id),
      child: CustomListTile(
        title: Text(
          todo.title,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: todo.finished ? Colors.black26 : Colors.black,
          ),
        ),
        subtitle:
            Text(AppSettings.dateTimeFormat.format(todo.notificationDateTime)),
        leading: CustomCheckbox(
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
        child: Icon(Icons.delete, color: accent, size: 32),
      ),
      onDismissed: (direction) => _remove(context),
      confirmDismiss: (_) async => await _showRemoveDialog(context) ?? false,
    );
  }

  Future<bool?> _showRemoveDialog(BuildContext context) async {
    return await showPlatformDialog<bool>(
      context: context,
      builder: (ctx) => RemoveDialog(),
    );
  }

  void _setFinished(BuildContext context, bool finished) =>
      Provider.of<TodoChangeNotifier>(context, listen: false)
          .save(todo.copyWith(finished: finished));

  void _remove(BuildContext context) =>
      Provider.of<TodoChangeNotifier>(context, listen: false).remove(todo);
}
