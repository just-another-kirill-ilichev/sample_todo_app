import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_todo_app/config/app_router.dart';
import 'package:sample_todo_app/model/meta_folder.dart';
import 'package:sample_todo_app/widget/custom_fab.dart';
import 'package:sample_todo_app/page/todo_list_page/todo_tile.dart';
import 'package:sample_todo_app/state/todo_change_notifier.dart';
import 'package:sample_todo_app/widget/custom_scaffold.dart';

class TodoListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<TodoChangeNotifier>(
      builder: (ctx, todos, ___) => CustomScaffold(
        title: Text(_getTitle(todos.currentFolder)),
        actions: [
          if (todos.currentFolder.type == MetaFolderType.folder)
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () => Navigator.pushNamed(
                context,
                AppRoute.edit_folder,
                arguments: todos.currentFolder.folder,
              ),
            )
        ],
        body: SliverList(
          delegate: SliverChildBuilderDelegate(
            (ctx, idx) => TodoTile(todo: todos.items[idx]),
            childCount: todos.items.length,
          ),
        ),
        floatingActionButton: CustomFab(
          onPressed: () => Navigator.pushNamed(context, AppRoute.add_todo),
          icon: Icon(Icons.add),
        ),
      ),
    );
  }

  String _getTitle(MetaFolder metaFolder) {
    switch (metaFolder.type) {
      case MetaFolderType.folder:
        return metaFolder.folder!.title;
      case MetaFolderType.all:
        return 'Все';
      case MetaFolderType.today:
        return 'Сегодня';
    }
  }
}
