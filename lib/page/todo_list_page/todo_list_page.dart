import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_todo_app/config/app_router.dart';
import 'package:sample_todo_app/page/todo_list_page/todo_tile.dart';
import 'package:sample_todo_app/state/todo_list.dart';

class TodoListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<TodoList>(
        builder: (ctx, todos, ___) => CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 200,
              pinned: true,
              backgroundColor: Theme.of(ctx).canvasColor,
              flexibleSpace: FlexibleSpaceBar(title: Text('Список')),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (ctx, idx) => TodoTile(todo: todos.items[idx]),
                childCount: todos.items.length,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, AppRoute.add_todo),
        tooltip: 'Add',
        child: Icon(Icons.add),
      ),
    );
  }
}
