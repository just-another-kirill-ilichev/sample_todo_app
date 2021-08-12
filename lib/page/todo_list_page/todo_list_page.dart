import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_todo_app/config/app_router.dart';
import 'package:sample_todo_app/page/todo_list_page/custom_fab.dart';
import 'package:sample_todo_app/page/todo_list_page/todo_tile.dart';
import 'package:sample_todo_app/state/todo_list.dart';
import 'package:sample_todo_app/widget/custom_scaffold.dart';

class TodoListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<TodoList>(
      builder: (ctx, todos, ___) => CustomScaffold(
        title: Text('Список'),
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
}
