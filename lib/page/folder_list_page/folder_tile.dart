import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_todo_app/config/app_router.dart';
import 'package:sample_todo_app/state/todo_change_notifier.dart';
import 'package:sample_todo_app/widget/custom_list_tile.dart';

class FolderTile extends StatelessWidget {
  final Widget icon, title;
  final TodoFilter filter;
  final int count;

  const FolderTile({
    Key? key,
    required this.icon,
    required this.title,
    required this.count,
    required this.filter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var primary = Theme.of(context).primaryColor;

    return CustomListTile(
      title: title,
      leading: IconTheme(data: IconThemeData(color: primary), child: icon),
      subtitle: Text('Fdsfkskfghrkjgjrvgbrkjbgkjere'),
      trailing: Text(count.toString()),
      onTap: () => _onTap(context),
    );
  }

  Future<void> _onTap(BuildContext context) async {
    Provider.of<TodoChangeNotifier>(context, listen: false).setFilter(filter);
    await Navigator.pushNamed(context, AppRoute.todo_list);
  }
}
